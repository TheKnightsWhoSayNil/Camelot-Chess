# /app/models/pawn.rb
class Pawn < Piece

  def valid_move?(x, y)
    super(x, y)
    return false if is_obstructed?(x, y)

    if color == 'WHITE'
      move_range = 1
      if is_capture?
        return (y == y_position+move_range && x == x_position+move_range) || (y == y_position+move_range && x == x_position-move_range)
      else
        return y <= y_position+move_range && x == x_position
        return false if space_occupied?(x, y) || !within_chessboard?(x, y)
      end

      if in_starting_position?
        move_range = (1..2)
        return y <= y_position+move_range && x == x_position
        return false if space_occupied?(x, y) || !within_chessboard?(x, y)
      end

    elsif color == 'BLACK'
      move_range = -1
      if is_capture?
        return (y == y_position+move_range && x == x_position+move_range) || (y == y_position+move_range && x == x_position-move_range)
      else
        return y >= y_position+move_range && x == x_position
        return false if space_occupied?(x, y) || !within_chessboard?(x, y)
      end

      if in_starting_position?
        move_range = (-2..-1)
        return y >= y_position+move_range && x == x_position
        return false if space_occupied?(x, y) || !within_chessboard?(x, y) 
      end
        
    end
  end


  def in_starting_position?
    if (color == 'WHITE' && y_position == 1) || (color == 'BLACK' && y_position == 6)
      return true
    else
      return false
    end
  end

  def is_capture?
    false
  end

end