# /app/models/pawn.rb
class Pawn < Piece

  def valid_move?(x, y)
    valid = super
    if valid
      if is_capture?(x, y)
        capture_piece_at!(x, y)
        return true
      elsif moving_backward?(y) || (one_square?(x, y) || two_squares?(x, y))
        return false
      end
    end
    return valid
  end

  def in_starting_position?
    if (color == 'WHITE' && y_position) == 1 || (color == 'BLACK' && y_position == 6)
      return true
    else
      return false
    end
  end

  def one_square?(x, y)
    if game.space_occupied?(x, y)
      return true
    end
    return !in_starting_position? && ((x - x_position).abs > 0 || (y - y_position).abs > 1)
  end

  def two_squares?(x, y)
    if game.space_occupied?(x, y)
      return true
    end
    return in_starting_position? && ((x - x_position). abs > 0 || (y - y_position).abs > 2)
  end

  def is_capture?(x, y)
    if game.space_occupied?(x, y)
      if (y - y_position).abs == 1 && (x - x_position).abs == 1
        return true
      end
    else
      return false
    end
  end

  def moving_backward?(y)
    if color == 'WHITE'
      if (y - y_position) < 0
        return true
      end
    elsif color == 'BLACK'
      if (y - y_position) > 0
        return true
      end
    end
    false
  end
end
