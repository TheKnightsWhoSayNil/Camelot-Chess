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

  def castle!(rook)
    return false unless can_castle?(rook)
    if queenside?(rook)
      update_attributes(x_position: 2, state: 'moved')
      rook.update_attributes(x_position: 3, state: 'moved')
      return true 
    else #kingside
      update_attributes(x_position: 6, state: 'moved')
      rook.update_attributes(x_position: 5, state: 'moved')
      return true 
    end 
  end 

  def can_castle?(rook)
    #to do: return false if in check
    #to do: return false if spaces between rook & king are obstructed 
    return false unless state == 'unmoved' #ensure king hasn't moved yet
    return false unless rook.state == 'unmoved' 
    true 
  end 

  def queenside?(rook)
    rook.x_position < x_position 
  end 

end
