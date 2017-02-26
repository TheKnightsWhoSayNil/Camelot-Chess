# Piece will hold all similar logic for all pieces.
class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def within_chessboard?(x, y)
    return true if x > 0 && y > 0 && x < 7 && y < 7
  end
  # should store all the possible diagonal moves 
  # excluding starting position hence "if x > 0"
  def diagonal_moves
      coordinates = []
      8.times do |x|
        if x > 0 
        coordinates << (x, x)
        coordinates << (x, -x)
        coordinates << (-x, x)
        coordinates << (-x, -x)
        end
      end
      return coordinates   
  end
  
  def diagonal_valid_moves(x_position, y_position)
    valid_move_coordinates = []
    diagonal_moves.each do |x, y|
      if within_chessboard(x_position + x, y_position + y)
        valid_move_coordinates << ((x_position + x), y_position + y)
      end
    end
    return valid_move_coordinates   
  end
end
