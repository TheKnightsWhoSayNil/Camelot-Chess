# /app/models/king.rb
class King < Piece
  def valid_move?(x, y)
    super(x, y)
    return false if is_obstructed?(x, y)
    standard_king_move(x, y) || castle!
  end

  def checkmate?
    # example logic
  end

  def legal_castle_move?
    return false unless self.state == 'unmoved'
  end

  def castle!
    castle_kingside if can_castle_kingside?
    castle_queenside if can_castle_queenside?
  end

  def can_castle_kingside?
    rook = game.pieces.where(piece_type: 'Rook', x_position: 7, state: 'unmoved')
    legal_castle_move?
    no_kingside_obstruction?
  end 

  def castle_kingside
    if can_castle_kingside?
      rook = game.pieces.where(piece_type: 'Rook', x_position: 7, state: 'unmoved')
      king = game.pieces.where(piece_type: 'King', x_position: 4, state: 'unmoved')
      rook.update_all(x_position: 5, state: 'moved')
      king.update_all(x_position: 6, state: 'moved')
    end
  end

  def can_castle_queenside?
    rook = game.pieces.where(piece_type: 'Rook', x_position: 0, state: 'unmoved')
    legal_castle_move?
    no_queenside_obstruction?
  end 

  def castle_queenside
    if can_castle_queenside?
      rook = game.pieces.where(piece_type: 'Rook', x_position: 0, state: 'unmoved')
      king = game.pieces.where(piece_type: 'King', x_position: 4, state: 'unmoved')
      rook.update_all(x_position: 3, state: 'moved')
      king.update_all(x_position: 2, state: 'moved')
    end
  end

  def no_kingside_obstruction?
    (5..6).each do |x|
      return false if space_occupied?(x, y_position)
    end 
    true 
  end 

  def no_queenside_obstruction?
    (1..3).each do |x|
      return false if space_occupied?(x, y_position)
    end 
    true 
  end

  private

  def change_location(x, y)
    update_attributes(x_position: x, y_position: y)
  end

  def standard_king_move(x, y)
    dx = (x - x_position).abs
    dy = (y - y_position).abs

    (dx <= 1) && (dy <= 1) && (dx + dy > 0)
  end
end
