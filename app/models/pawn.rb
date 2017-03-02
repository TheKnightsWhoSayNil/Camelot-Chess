# /app/models/pawn.rb
class Pawn < Piece

  def valid_move?(x, y)
    super(x, y)

    #set to true to pass make the 
    # return false if x != x_position

    if color == true
      move = 1
      
      if is_capture?
        return y <= y_position+move && x <= x_position+move || x <= x_position-move      
      elsif in_starting_position?
        move = 2
        return y <= y_position+move && x == x_position
      else
        return y <= y_position+move && x == x_position
      end

    else
      move = -1
      if is_capture? 
        return y >= y_position+move && x >= x_position+move || x >= x_position-move
      elsif in_starting_position?
        move = -2
        return y >= y_position+move && x == x_position
      else
        return y >= y_position+move && x == x_position
      end

    end

  end


  def in_starting_position?
    if color == true
      y_position == 1
    else
      y_position == 6
    end
  end


  def is_capture?
      false
  end     
  
end
