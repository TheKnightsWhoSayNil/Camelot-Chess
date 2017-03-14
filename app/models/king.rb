# /app/models/king.rb
class King < Piece

=begin  def valid_move?(x, y)
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
=end 

  def valid_move?(x, y)
    super(x, y)
    return true if king_move(x, y) 
    if can_castle?(x, y)
      castle!
      return true 
    end 
    false
  end 

  def king_move(x, y)
    dx = (x - x_position).abs
    dy = (y - y_position).abs
    dx <= 1 && dy <= 1
  end 
  

  def checkmate?
    # example logic
  end

  def castle_rook(side)
    case side
    when 'Kingside'
      game.pieces.find_by(
        piece_type: 'Rook',
        x_position: 7,
        y_position: y_position)
    when 'Queenside'
      game.pieces.find_by(
        piece_type: 'Rook',
        x_position: 0,
        y_position: y_position)
    else 
      return nil 
    end 
  end 

  def can_castle?(x, y)
    #rtn false if in check
    return false unless state == 'unmoved'
    if x > x_position
      @rook = castle_rook('Kingside')
      @new_king_x = 6
      @new_rook_x = 5 
    else 
      @rook = castle_rook('Queenside')
      @new_rook_x = 3 
      @new_king_x = 2 
    end 

    return false if castle_rook.nil? 
    return false unless castle_rook.state == 'unmoved'
    true 
  end 

  def castle! 
    update_attributes(@new_king_x, y_position)
    @rook.update_attributes(@new_rook_x, y_position)
  end 
end 
=begin
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
    return false if piece.is_obstructed?(rook.x_position, rook.y_position)
    return false unless state == 'unmoved' #ensure king hasn't moved yet
    return false unless rook.state == 'unmoved' 
    true 
  end 

  def queenside?(rook)
    rook.x_position < x_position 
  end 
=end
