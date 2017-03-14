# Game will hold all Game Logic, gameboard etc.

class Game < ApplicationRecord
  belongs_to :white_user, class_name: 'User'
  belongs_to :black_user, class_name: 'User', optional: true

  has_many :pieces

  after_create :fill_board

  scope :available, ->{ where(black_user_id: nil) }

  def in_check?(color)
    king = pieces.find_by(piece_type: "King", color: true)

    # Find king
    # Find all pieces for the color that is not the king
    # for each piece do this:
    #   if piece.available_moves.include (kings coordinates)
    #     return true
    # end
    # end
    opponents = pieces.where(color: false)
    opponents.each do |piece|
      if piece.move_to?(king.x_position, king.y_position)
        return true
      end
      false
    end
  end

  def available?
    self.black_user.blank?
  end

  def black_pieces
    self.pieces.where(color: 'BLACK')
  end

  def white_pieces
    self.pieces.where(color: 'WHITE')
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
      Pawn.create(game_id: self.id, x_position: i, y_position: 1, image: 'white_pawn.png',  color: 'WHITE')
    end

    Rook.create(game_id: self.id, x_position: 0, y_position: 0, image: 'white_rook.png', color: 'WHITE')
    Rook.create(game_id: self.id, x_position: 7, y_position: 0, image: 'white_rook.png', color: 'WHITE')
    Knight.create(game_id: self.id, x_position: 1, y_position: 0, image: 'white_knight.png', color: 'WHITE')
    Knight.create(game_id: self.id, x_position: 6, y_position: 0, image: 'white_knight.png', color: 'WHITE')
    Bishop.create(game_id: self.id, x_position: 2, y_position: 0, image: 'white_bishop.png', color: 'WHITE')
    Bishop.create(game_id: self.id, x_position: 5, y_position: 0, image: 'white_bishop.png', color: 'WHITE')
    Queen.create(game_id: self.id, x_position: 3, y_position: 0, image: 'white_queen.png', color: 'WHITE')
    King.create(game_id: self.id, x_position: 4, y_position: 0, image: 'white_king.png', color: 'WHITE')

    # fill black pieces
    (0..7).each do |i|
      Pawn.create(game_id: self.id, x_position: i, y_position: 6, image: 'black_pawn.png', color: 'BLACK')
    end

    Rook.create(game_id: self.id, x_position: 0, y_position: 7, image: 'black_rook.png', color: 'BLACK')
    Rook.create(game_id: self.id, x_position: 7, y_position: 7, image: 'black_rook.png', color: 'BLACK')
    Knight.create(game_id: self.id, x_position: 1, y_position: 7, image: 'black_knight.png', color: 'BLACK')
    Knight.create(game_id: self.id, x_position: 6, y_position: 7, image: 'black_knight.png', color: 'BLACK')
    Bishop.create(game_id: self.id, x_position: 2, y_position: 7, image: 'black_bishop.png', color: 'BLACK')
    Bishop.create(game_id: self.id, x_position: 5, y_position: 7, image: 'black_bishop.png', color: 'BLACK')
    Queen.create(game_id: self.id, x_position: 3, y_position: 7, image: 'black_queen.png', color: 'BLACK')
    King.create(game_id: self.id, x_position: 4, y_position: 7, image: 'black_king.png', color: 'BLACK')
  end

  def self.all_board_coordinates
    result = []
    (0..7).to_a.each do |x|
      (0..7).to_a.each do |y|
        result << [x,y]
      end
    end
    result
  end

end
