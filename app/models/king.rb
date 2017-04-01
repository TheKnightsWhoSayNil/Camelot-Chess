# /app/models/king.rb
class King < Piece
  def valid_move?(x, y)
    if super(x, y)
      if legal_castle_move?
        castle!
        true
      else
        return standard_king_move?(x, y)
      end
    end
    false
  end

  def checkmate?
    # example logic
  end

  def castle!
    if can_castle_queenside?
      castle_queenside
    else can_castle_kingside?
      castle_kingside
    end
  end

  def can_castle_kingside?
    rook = game.pieces.where(piece_type: 'Rook', x_position: 7, state: 'unmoved').take
    if rook.nil?
      return false
    else
      legal_castle_move? && no_kingside_obstruction?
    end
  end

  def castle_kingside
    rook = game.pieces.where(piece_type: 'Rook', x_position: 7).take
    king = game.pieces.where(piece_type: 'King', x_position: 4).take

    if rook.color == 'WHITE' && king.color == 'WHITE'
      rook.update_attributes(x_position: 5, state: 'moved')
      king.update_attributes(x_position: 6, state: 'moved')
    else rook.color == 'BLACK' && king.color == 'BLACK'
      rook.update_attributes(x_position: 5, state: 'moved')
      king.update_attributes(x_position: 6, state: 'moved')
    end
    rook.reload
    king.reload
    
  end

  def can_castle_queenside?
    rook = game.pieces.where(piece_type: 'Rook', x_position: 0, state: 'unmoved').take
    if rook.nil?
      return false
    else
      legal_castle_move? && no_queenside_obstruction?
    end
  end

  def castle_queenside
    rook = game.pieces.where(piece_type: 'Rook', x_position: 0).take
    king = game.pieces.where(piece_type: 'King', x_position: 4).take

    if rook.color == 'WHITE' && king.color == 'WHITE'
      rook.update_attributes(x_position: 3, state: 'moved')
      king.update_attributes(x_position: 2, state: 'moved')
    else rook.color == 'BLACK' && king.color == 'BLACK'
      rook.update_attributes(x_position: 3, state: 'moved')
      king.update_attributes(x_position: 2, state: 'moved')
    end
    rook.reload
    king.reload
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

  def standard_king_move?(x, y)
    dx = (x - x_position).abs
    dy = (y - y_position).abs
    if dx >= 2 || dy >= 2
      return false
    elsif dx == 0 && dy == 0
      return false
    else (dx <= 1) && (dy <= 1) && (dx + dy > 0)
      return true
    end
  end

  def legal_castle_move?
    king = game.pieces.where(piece_type: 'King').take
    rook = game.pieces.where(piece_type: 'Rook').take
    if (king.state == 'unmoved') && (rook != nil) && (rook.state == 'unmoved')
      return true
    else
      return false
    end
  end
end