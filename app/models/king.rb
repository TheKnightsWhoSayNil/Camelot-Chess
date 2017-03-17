# /app/models/king.rb
class King < Piece
  def valid_move?(x, y)
   super(x, y)

   move_range = [[-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1]]
   move_coordinates = []

   move_range.each do |dx, dy|
     if within_chessboard?(x_position + dx, y_position + dy)
       move_coordinates << [(x_position + dx), (y_position + dy)]
     end
   end

  return move_coordinates.include?([x,y])

 end

  def checkmate?
    # example logic
  end

  def castle_rook(x)
    @castle_rook ||= game.pieces.find_by(
      piece_type: 'Rook',
      x_position: (x > x_position ? 7:0),
      y_position: y_position)
  end

  def can_castle?(x, y)
    state == 'unmoved' &&
      !castle_rook(x).nil? &&
      castle_rook(x).state == 'unmoved'
  end

  def castle!

  end

end
