# /app/models/rook.rb
class Rook < Piece
  # logic for Rook specifics
  def valid_move?(x, y) #rook = horizontal or vertical only
    self.horizontal_moves(x, y) || self.vertical_moves(x, y)
  end
end
