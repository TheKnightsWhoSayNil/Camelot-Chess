# Game will hold all Game Logic, gameboard etc.
require 'pry'
class Game < ApplicationRecord
  belongs_to :white_user, class_name: 'User'
  belongs_to :black_user, class_name: 'User', optional: true

  has_many :pieces

  after_create :fill_board

  scope :available, -> { where(black_user_id: nil) }

  def in_check?(color)
    king = find_king(color)
    opponents = opponents_pieces(color)
    @enemies_causing_check = []
    opponents.each do |piece|
      @enemies_causing_check << piece if piece.valid_move?(king.x_position, king.y_position) == true
    end
    return true if @enemies_causing_check.any?
    false
  end

  def stalemate?(color)
    your_pieces = my_pieces(color)
    available_moves = []
    your_pieces.each do |piece|
      1.upto(8) do |x|
        1.upto(8) do |y|
          if piece.valid_move?(x, y) && !piece.move_causes_check?(x, y)
            available_moves << [x, y]
          end
        end
      end
    end
    return false if available_moves.any?
    true
  end

  def checkmate?(color)
    return false unless in_check?(color)
    return false if capture_opponent_causing_check?(color)
    return false if i_can_move_out_of_check?(color)
    return false if can_be_blocked?(king)
    true
  end

  def i_can_move_out_of_check?(color)
    king = find_king(color)
    x_start = king.x_position
    y_start = king.y_position
    state = false
    ((king.x_position - 1)..(king.x_position + 1)).each do |x|
      ((king.y_position - 1)..(king.y_position + 1)).each do |y|
        king.update(x_position: x, y_position: y) if king.valid_move?(x, y)
        state = true unless in_check?(color)
        king.update(x_position: x_start, y_position: y_start)
      end
    end
    state
  end

  def capture_opponent_causing_check?(color)
    friendlies = my_pieces(color)
    the_liberator = []
    friendlies.each do |friend|
      @enemies_causing_check.each do |enemy|
        the_liberator << friend if friend.valid_move?(enemy.x_position, enemy.y_position) == true
      end
    end
    return true if the_liberator.any?
    false
  end

  def fill_board
    # fill white pieces
    (0..7).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 1, color: 'WHITE')
    end

    Rook.create(game_id: id, x_position: 0, y_position: 0, color: 'WHITE')
    Rook.create(game_id: id, x_position: 7, y_position: 0, color: 'WHITE')
    Knight.create(game_id: id, x_position: 1, y_position: 0, color: 'WHITE')
    Knight.create(game_id: id, x_position: 6, y_position: 0, color: 'WHITE')
    Bishop.create(game_id: id, x_position: 2, y_position: 0, color: 'WHITE')
    Bishop.create(game_id: id, x_position: 5, y_position: 0, color: 'WHITE')
    Queen.create(game_id: id, x_position: 3, y_position: 0, color: 'WHITE')
    King.create(game_id: id, x_position: 4, y_position: 0, color: 'WHITE')

    # fill black pieces
    (0..7).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 6, color: 'BLACK')
    end

    Rook.create(game_id: id, x_position: 0, y_position: 7, color: 'BLACK')
    Rook.create(game_id: id, x_position: 7, y_position: 7, color: 'BLACK')
    Knight.create(game_id: id, x_position: 1, y_position: 7, color: 'BLACK')
    Knight.create(game_id: id, x_position: 6, y_position: 7, color: 'BLACK')
    Bishop.create(game_id: id, x_position: 2, y_position: 7, color: 'BLACK')
    Bishop.create(game_id: id, x_position: 5, y_position: 7, color: 'BLACK')
    Queen.create(game_id: id, x_position: 3, y_position: 7, color: 'BLACK')
    King.create(game_id: id, x_position: 4, y_position: 7, color: 'BLACK')
  end

  def my_pieces(color)
    friendly_pieces = if color == 'BLACK'
                       'BLACK'
                     else
                       'WHITE'
                     end
    pieces.where(color: friendly_pieces).to_a
  end

  def opponents_pieces(color)
    opposing_color = if color == 'BLACK'
                       'WHITE'
                     else
                       'BLACK'
                     end
    pieces.where(color: opposing_color).to_a
  end

  def available?
    black_user.blank?
  end

  def black_pieces
    pieces.where(color: 'BLACK')
  end

  def white_pieces
    pieces.where(color: 'WHITE')
  end

  def space_occupied?(x, y)
    self.pieces.where(x_position: x, y_position: y).present?
  end

  def piece_image
    "#{color.downcase}_#{piece_type.downcase}.png"
  end

  def find_king(color)
    pieces.find_by(piece_type: "King", color: color)
  end

  def self.all_board_coordinates
    result = []
    (0..7).to_a.each do |x|
      (0..7).to_a.each do |y|
        result << [x, y]
      end
    end
    result
  end
end
