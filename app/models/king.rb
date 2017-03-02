# /app/models/king.rb
class King < Piece

  def valid_move?(x, y)
    super(x, y)

    valid_move_coordinates = []
    move_distance.each do |x, y|
        valid_move_coordinates << [(x_position + x), (y_position + y)]
      end
    end
    return valid_move_coordinates   


  end

  # logic for King specifics
  def move_distance
    coordinates = [[-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1]]
  end
    
  

# only available if no previous moves
def castle_king(x_position, y_position)
  valid_move_coordinates = []
  if @king.color
    if x_position ==  4 && y_position == 0
      valid_move_coordinates << [(x_position + 2, y_position)]
    else
      return false
    end
  else 
    if x_position == 4 && y_position == 7
      valid_move_coordinates << [(x_position + 2, y_position)]
    else
      return false

    end
  end
end



        

  end

  def checkmate?
    # example logic
  end

  
end
