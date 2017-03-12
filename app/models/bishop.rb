# /app/models/bishop.rb
class Bishop < Piece
  def valid_move?(x, y)
    super(x, y)
    (x_position - x).abs == (y_position - y).abs
  end
end
