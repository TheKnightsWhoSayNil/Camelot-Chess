# /app/models/pawn.rb
class Pawn < Piece

  def valid_move?(x, y)
    super(x, y)

    #set to true to pass make the
    # return false if x != x_position

    if color == 'WHITE'
      move_range = 1

      if is_capture?
        return y == y_position+move_range && x == x_position+move_range || y == y_position+move_range && x == x_position-move_range
      elsif in_starting_position?
        move_range = 2
        return y <= y_position+move_range && x == x_position
      else
        return y <= y_position+move_range && x == x_position
      end

    else
      move_range = -1
      if is_capture?
        return y == y_position+move_range && x == x_position+move_range || y == y_position+move_range && x == x_position-move_range
      elsif in_starting_position?
        move_range = -2
        return y >= y_position+move_range && x == x_position
      else
        return y >= y_position+move_range && x == x_position
      end

    end

  end


  def in_starting_position?
    if color == 'WHITE'
      y_position == 1
    else
      y_position == 6
    end
  end


  def is_capture?
      false
  end

end
