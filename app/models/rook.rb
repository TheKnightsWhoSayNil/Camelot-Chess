# /app/models/rook.rb
class Rook < Piece
  #rook = moves horizontal or vertical through any number of unoccupied tiles 
  def valid_move?(x, y) #return false if not valid move 
    super(x, y)
    horizontal_move?(x,y) || vertical_move?(x,y)
  end

end 