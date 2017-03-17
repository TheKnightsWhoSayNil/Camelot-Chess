# /app/models/king.rb
class King < Piece
  def valid_move?(x, y)
    super(x, y) && (valid_king_move?(x, y)) || (can_castle?(x,y))
  end

  def valid_king_move?(x, y)
    dx = (x - x_position).abs
    dy = (y - y_position).abs
    dx <= 1 && dy <= 1 && dx + dy > 0
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
