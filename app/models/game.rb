# Game will hold all Game Logic, gameboard etc.
require 'pry'
class Game < ApplicationRecord
  belongs_to :white_user, class_name: 'User'
  belongs_to :black_user, class_name: 'User', optional: true

  has_many :pieces

  after_create :fill_board

  scope :available, -> { where(black_user_id: nil) }

  def piece_image
    "#{color.downcase}_#{piece_type.downcase}.png"
  end

  def in_check?(color)
    king = pieces.find_by(piece_type: "King", color: color)
    opponents = opponents_pieces(color)
    opponents.each do |piece|
      return true if piece.valid_move?(king.x_position, king.y_position)
    end
    false
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

  def space_occupied?(x, y)
    self.pieces.where(x_position: x, y_position: y).present?
  end

  def black_pieces
    pieces.where(color: 'BLACK')
  end

  def white_pieces
    pieces.where(color: 'WHITE')
  end

  # def assign_pieces
  #   pieces.where(color: true).each do |p|
  #     p.update_attributes(player_id: white_user_id)
  #   end
  #   pieces.where(color: false).each do |p|
  #     p.update_attributes(player_id: black_user_id)
  #   end
  # end

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
