# /app/models/queen.rb
class Queen < Piece
  def valid_move?(x, y)
    if diagonal_move?(x, y) || horizontal_move?(x, y) || vertical_move?(x, y)
      return true 
    end 
    false 
  end

  def diagonal_move?(x, y)
    if (y_position - y).abs == (x_position - x).abs
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

  def horizontal_move?(x, y)
    if y_position == y && x_position != x
      return true
    end
    false
  end
end
