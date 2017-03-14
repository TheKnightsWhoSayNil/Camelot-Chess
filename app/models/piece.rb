 # Piece will hold all similar logic for all pieces.
class Piece < ApplicationRecord
  after_initialize :set_default_state
  belongs_to :game

  self.inheritance_column = :piece_type
  scope :bishops, ->{ where(piece_type: "Bishop") }
  scope :kings,   ->{ where(piece_type: "King") }
  scope :knights, ->{ where(piece_type: "Knight") }
  scope :queens,  ->{ where(piece_type: "Queen") }
  scope :pawns,   ->{ where(piece_type: "Pawn") }
  scope :rooks,   ->{ where(piece_type: "Rook") }

  def move_to!(x, y)
    if unoccupied?(x,y)
      update_attributes(x_position: x, y_position: y)
    elsif occupied_by_opposing_piece?(x,y)
      capture_piece_at!(x,y)
      update_attributes(x_position: x, y_position: y)
    elsif occupied_by_mycolor_piece?(x,y)
      return false
    end
  end

  def valid_move?(x, y)
    return false if !within_chessboard?(x, y)
  end

  def self.piece_types
    %w(Pawn Knight Bishop Rook Queen King)
  end

  def within_chessboard?(x, y)
    (x >= 0 && y >= 0 && x <= 7 && y <= 7)
  end

  #should store all the possible diagonal moves
  # excluding starting position hence "if x > 0"
  def diagonal_moves
    coordinates = []
      8.times do |x|
        if x > 0
        coordinates << [x, x]
        coordinates << [x, -x]
        coordinates << [-x, x]
        coordinates << [-x, -x]
         end
       end
       return coordinates
   end

  def diagonal_move_valid?(x_position, y_position)
    coordinates = []
    diagonal_moves_all.each do |x, y|
      if within_chessboard?(x + current_position[0], y + current_position[1])
          coordinates << [(x + current_position[0]), (y + current_position[1])]
      end
    end
    return coordinates.includes?([x_position, y_position]) ? true : false
  end

 def horizontal_moves
    coordinates = []
      8.times do |x|
        if x > 0
        coordinates << [x, 0]
        coordinates << [-x, 0]
        end
      end
      return coordinates
  end

  def horizontal_valid_moves(x_position, y_position)
    valid_move_coordinates = []
    horizontal_moves.each do |x, y|
      if within_chessboard?(x_position + x, y_position + y)
        valid_move_coordinates << [(x_position + x), (y_position + y)]
      end
    end
    return valid_move_coordinates
  end

  def vertical_moves
    coordinates = []
      8.times do |y|
        if y > 0
        coordinates << [0, y]
        coordinates << [0, -y]
        end
      end
      return coordinates
  end

  def vertical_valid_moves(x_position, y_position)
    valid_move_coordinates = []
    vertical_moves.each do |x, y|
      if within_chessboard?(x_position + x, y_position + y)
        valid_move_coordinates << [(x_position + x), (y_position + y)]
      end
    end
    return valid_move_coordinates
  end

#======


  def horizontal_obstruction(x_end, y_end)
    # movement: right to left
    if x_position < x_end
      (x_position + 1).upto(x_end - 1) do |x|
        return true if space_occupied?(x, y_position)
      end
    end
    # movement: left to right
    if x_position > x_end
      (x_position - 1).downto(x_end + 1) do |x|
        return true if space_occupied?(x, y_position)
      end
    end
  end

  def vertical_obstruction(x_end, y_end)
    # path is vertical down
    if y_position < y_end
        (y_position + 1).upto(y_end - 1) do |y|
        return true if space_occupied?(x_position, y)
      end
    end
    # path is vertical up
    if y_position > y_end
      (y_position - 1).downto(y_end + 1) do |y|
        return true if space_occupied?(x_position, y)
      end
    end
  end

  def diagonal_obstruction(x_end, y_end)
    # path is diagonal and down
    if x_position < x_end
      (x_position + 1).upto(x_end - 1) do |x|
        delta_y = x - x_position
        y = y_end > y_position ? y_position + delta_y : y_position - delta_y
        return true if space_occupied?(x, y)
      end
    end
    # path is diagonal and up
    if x_position > x_end
      (x_position - 1).downto(x_end + 1) do |x|
        delta_y = x_position - x
        y = y_end > y_position ? y_position + delta_y : y_position - delta_y
        return true if space_occupied?(x, y)
      end
    end
  end

  def is_obstructed?(destination)
    x_end = destination[0]
    y_end = destination[1]
    path = check_path(x_position, y_position, x_end, y_end)

    if path == 'horizontal'
      return horizontal_obstruction(x_end, y_end)
    end

    if path == 'vertical'
      return vertical_obstruction(x_end, y_end)
    end

    if path == 'diagonal'
      return diagonal_obstruction(x_end, y_end)
    end

    return false
  end

  def space_occupied?(x, y)
    game.pieces.where(x_position: x, y_position: y).present?
  end

  def check_path(x_position, y_position, x_end, y_end)
    if y_position == y_end
      return 'horizontal'
    elsif x_position == x_end
      return 'vertical'
    elsif (y_end - y_position).abs == (x_end - x_position).abs
      return 'diagonal'
    else
      return nil
    end
  end

  def capture_piece_at!(x,y)
    piece_at(x,y).update_attributes(x_position: nil, y_position: nil)
  end

  def unoccupied?(x,y)
    !space_occupied?(x,y)
  end

  def occupied_by_mycolor_piece?(x,y)
    space_occupied?(x,y) && (piece_at(x,y).color == self.color)
  end

  def occupied_by_opposing_piece?(x,y)
    space_occupied?(x,y) && (piece_at(x,y).color != self.color)
  end

  def piece_at(x, y)
    game.pieces.where(x_position: x, y_position: y).take
  end

  def diagonal_move?(x, y)
    (y_position - y).abs == (x_position - x).abs
  end

  def vertical_move?(x, y)
    x_position == x && y_position != y
  end

  def horizontal_move?(x, y)
    y_position == y && x_position != x
  end

  private

  def set_default_state
    self.state ||= 'unmoved'
  end
end
