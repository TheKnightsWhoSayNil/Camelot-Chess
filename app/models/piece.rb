# Piece will hold all similar logic for all pieces.
class Piece < ApplicationRecord
  after_initialize :set_default_state
  belongs_to :game

  self.inheritance_column = :piece_type
  scope :bishops, -> { where(piece_type: "Bishop") }
  scope :kings,   -> { where(piece_type: "King") }
  scope :knights, -> { where(piece_type: "Knight") }
  scope :queens,  -> { where(piece_type: "Queen") }
  scope :pawns,   -> { where(piece_type: "Pawn") }
  scope :rooks,   -> { where(piece_type: "Rook") }

  def piece_image
    "#{color.downcase}_#{piece_type.downcase}.png"
  end

  def move_to!(x, y)
    if color == game.user_turn
      if valid_move?(x, y) && space_available?(x,y) && not_into_check?(x,y)
        if occupied_by_opposing_piece?(x, y)
          capture_piece_at!(x, y)
          game.pass_turn!(game.user_turn)
          change_location(x, y)
        elsif !occupied_by_opposing_piece?(x, y)
          change_location(x, y)
          game.pass_turn!(game.user_turn)
        end
      else
        false
      end
    end
  end

  def not_into_check?(x,y)
    !move_causes_check?(x,y)
  end

  def valid_move?(x, y)
    return false if is_obstructed?(x, y)
    return false if occupied_by_mycolor_piece?(x, y)
    within_chessboard?(x, y)
  end

  def self.piece_types
    %w(Pawn Knight Bishop Rook Queen King)
  end

  def within_chessboard?(x, y)
    (x >= 0 && y >= 0 && x <= 7 && y <= 7 && x != nil && y != nil)
  end

  def horizontal_obstruction?(x_end, _y_end)
    # movement: right to left
    if x_position < x_end
      (x_position + 1).upto(x_end - 1) do |x|
        return true if space_occupied?(x, y_position)
      end
    # movement: left to right
    elsif x_position > x_end
      (x_position - 1).downto(x_end + 1) do |x|
        return true if space_occupied?(x, y_position)
      end
    end
    false
  end

  def vertical_obstruction(x_end, y_end)
    # path is vertical down
    if y_position < y_end
      (y_position + 1).upto(y_end - 1) do |y|
        return true if space_occupied?(x_position, y)
      end
    # path is vertical up
    elsif y_position > y_end
      (y_position - 1).downto(y_end + 1) do |y|
        return true if space_occupied?(x_position, y)
      end
    end
    false
  end

  def diagonal_obstruction(x_end, y_end)
    # path is diagonal and down
    if x_position < x_end
      (x_position + 1).upto(x_end - 1) do |x|
        delta_y = x - x_position
        y = y_end > y_position ? y_position + delta_y : y_position - delta_y
        return true if space_occupied?(x, y)
      end
    # path is diagonal and up
    elsif x_position > x_end
      (x_position - 1).downto(x_end + 1) do |x|
        delta_y = x_position - x
        y = y_end > y_position ? y_position + delta_y : y_position - delta_y
        return true if space_occupied?(x, y)
      end
    end
    false
  end

  def is_obstructed?(x, y)
    x_end = x
    y_end = y
    path = check_path(x_position, y_position, x_end, y_end)

    return horizontal_obstruction?(x_end, y_end) if path == 'horizontal'

    return vertical_obstruction(x_end, y_end) if path == 'vertical'

    return diagonal_obstruction(x_end, y_end) if path == 'diagonal'

    false
  end

  def can_be_blocked?(color)
    checked_king = game.find_king(color)
    obstruction_array = obstructed_squares(checked_king.x_position, checked_king.y_position)
    opponents = game.opponents_pieces(!color)
    opponents.each do |opponent|
      next if opponent.piece_type == 'King'
      obstruction_array.each do |square|
        return true if opponent.valid_move?(square[0], square[1])
      end
    end
    false
  end

  def move_causes_check?(x, y)
    state = false
    ActiveRecord::Base.transaction do
      change_location(x,y)
      state = game.in_check?(color)
      raise ActiveRecord::Rollback
    end
    reload
    state
  end

  def space_occupied?(x, y)
    game.pieces.where(x_position: x, y_position: y).present?
  end

  def check_path(x_position, y_position, x_end, y_end)
    if y_position == y_end
      'horizontal'
    elsif x_position == x_end
      'vertical'
    elsif (y_end - y_position).abs == (x_end - x_position).abs
      'diagonal'
    end
  end

  def capture_piece_at!(x, y)
    piece_at(x, y).update_attributes(x_position: nil, y_position: nil)
  end

  def unoccupied?(x, y)
    !space_occupied?(x, y)
  end

  def occupied_by_mycolor_piece?(x, y)
    space_occupied?(x, y) && (piece_at(x, y).color == color)
  end

  def occupied_by_opposing_piece?(x, y)
    space_occupied?(x, y) && (piece_at(x, y).color != color)
  end

  def piece_at(x, y)
    game.pieces.find_by(x_position: x, y_position: y)
  end

  def diagonal_move?(x, y)
    (y_position - y).abs == (x_position - x).abs
  end

  def vertical_move?(x, y)
    x_position == x && y_position != y
  end

  def horizontal_move?(x, y)
    (y_position == y) && (x_position != x) ? true : false
  end

  def available_moves
    Game.all_board_coordinates.select do |coordinate_pair|
      valid_move?(coordinate_pair[0], coordinate_pair[1]) &&
        !is_obstructed?(coordinate_pair[0], coordinate_pair[1]) &&
        !occupied_by_mycolor_piece?(coordinate_pair[0], coordinate_pair[1])
    end
  end

  def find_piece(piece_type, x, y)
    game.pieces.where(piece_type: piece_type, x_position: x, y_position: y).take
  end

  private

  def change_location(x,y)
    update_attributes(x_position: x, y_position: y)
  end

  def space_available?(x,y)
    !occupied_by_mycolor_piece?(x, y)
  end

  def space_occupied?(x, y)
    game.pieces.where(x_position: x, y_position: y).present?
  end

  def set_default_state
    self.state ||= 'unmoved'
  end
end
