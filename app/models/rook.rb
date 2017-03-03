# /app/models/rook.rb
class Rook < Piece
  # logic for Rook specifics
  def valid_move?(x, y) #rook = horizontal or vertical only
    self.horizontal_valid_moves(x, y) || self.vertical_valid_moves(x, y)
  end
end
