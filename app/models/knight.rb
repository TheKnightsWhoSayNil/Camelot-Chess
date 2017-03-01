# /app/models/knight.rb
class Knight < Piece
  # logic for Knight specifics
  def knight_moves
    coordinates = [[1,2], [1,-2], [2,1], [2,-1], [-1,2], [-1,-2], [-2,1], [-2,-1]]
  end
    
  def knight_valid_moves(x_position, y_position)
    valid_move_coordinates = []
    knight_moves.each do |x, y|
      if within_chessboard?(x_position + x, y_position + y)
        valid_move_coordinates << [(x_position + x), (y_position + y)]
      end
    end
    return valid_move_coordinates   
  end
  
end
