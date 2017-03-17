# /app/models/rook.rb
class Rook < Piece
  def valid_move?(x, y)
    super(x, y)
    return false if is_obstructed?(x, y)
    horizontal_move?(x, y) || vertical_move?(x, y)
  end
end
