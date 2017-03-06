# /app/models/rook.rb
class Rook < Piece
  #rook = moves horizontal or vertical through any number of unoccupied tiles 
  def valid_move?(x, y) #return false if not valid move 
    horizontal_move?(x,y) || vertical_move?(x,y) 
  end

  def horizontal_move?(x,y)
    delta_x = x_position - x
    delta_y = y_position - y

    delta_y == 0 && delta_x != 0
  end

  def vertical_move?(x,y)
    delta_x = x_position - x
    delta_y = y_position - y

    delta_y != 0 && delta_x == 0
  end
end


