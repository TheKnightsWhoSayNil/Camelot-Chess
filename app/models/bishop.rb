# /app/models/bishop.rb
class Bishop < Piece
  # logic for Bishop specifics
  def valid_move?(x, y)
    (x_position - x).abs == (y_position - y).abs
  end
end
