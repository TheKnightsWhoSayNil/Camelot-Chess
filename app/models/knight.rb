# /app/models/knight.rb
class Knight < Piece

  def valid_move?(x, y)
    super(x, y)

    move_range = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
    move_coordinates = []

    move_range.each do |dx, dy|
      move_coordinates << [(x_position + dx), (y_position + dy)]
    end
    move_coordinates.include?([x,y])
  end

end
