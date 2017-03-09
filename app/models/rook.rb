# /app/models/rook.rb
class Rook < Piece
  #rook = moves horizontal or vertical through any number of unoccupied tiles 
  def valid_move?(x, y) #return false if not valid move 
    horizontal_move?(x,y) || vertical_move?(x,y) 
  end

  def horizontal_move?(x, y)
    if y_position == y && x_position != x
      return true
    end
    false
  end

  def vertical_move?(x, y)
    if x_position == x && y_position != y
      return true
    end
    false
  end
end 