# /app/models/queen.rb
require 'pry'
class Queen < Piece

  def valid_move?(x, y)
    super(x, y)
    return false if is_obstructed?(x, y)
    diagonal_move?(x, y) || horizontal_move?(x, y) || vertical_move?(x, y)
  end

end
