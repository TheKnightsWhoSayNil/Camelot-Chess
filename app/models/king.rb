# /app/models/king.rb
class King < Piece
  def valid_move?(x, y)
    if super(x, y)
      if valid_king_move?(x, y)
        change_location(x,y)
      elsif can_castle_kingside? || can_castle_queenside?
        castle!
      end
    end
    false
  end

  def valid_king_move?(x, y)
    dx = (x - x_position).abs
    dy = (y - y_position).abs
    dx <= 1 && dy <= 1 && dx + dy > 0
  end

  def checkmate?
    # example logic
  end

  def castle!
    castle_kingside if can_castle_kingside?
    castle_queenside if can_castle_queenside?
  end

  def can_castle_kingside?
    rook = game.pieces.where(piece_type: 'Rook', x_position: 7, state: 'unmoved').take
    king = game.pieces.where(piece_type: 'King', x_position: 4, state: 'unmoved').take
    no_kingside_obstruction?
  end 

  def castle_kingside
    if can_castle_kingside?
      rook = game.pieces.where(piece_type: 'Rook', x_position: 7, state: 'unmoved').take
      king = game.pieces.where(piece_type: 'King', x_position: 4, state: 'unmoved').take
      rook.update_attributes(x_position: 5, state: 'moved')
      king.update_attributes(x_position: 6, state: 'moved')
    end
    false
  end

  def can_castle_queenside?
    rook = game.pieces.where(piece_type: 'Rook', x_position: 0, state: 'unmoved').take
    king = game.pieces.where(piece_type: 'King', x_position: 4, state: 'unmoved').take
    no_queenside_obstruction?
  end 

  def castle_queenside
    if can_castle_queenside?
      rook = game.pieces.where(piece_type: 'Rook', x_position: 0, state: 'unmoved').take
      king = game.pieces.where(piece_type: 'King', x_position: 4, state: 'unmoved').take
      rook.update_attributes(x_position: 3, state: 'moved')
      king.update_attributes(x_position: 2, state: 'moved')
    end
    false
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

  def change_location(x,y)
    update_attributes(x_position: x, y_position: y)
  end
end
