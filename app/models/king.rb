# /app/models/king.rb
class King < Piece
  def valid_move?(x, y)
   super(x, y)
   return false if is_obstructed?(x, y)
   
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

  def castle!(x, y)
    castle_kingside if can_castle_kingside?(x)
    castle_queenside if can_castle_queenside(x)
  end 

  def passes_castle_conditions?(rook)
    state == 'unmoved' &&
      rook.state == 'unmoved' &&
      !rook.nil? 
  end

  def can_castle_queenside?(x)
    rook = find_piece(7, y_position)
    return false unless passes_castle_conditions?(rook)
    no_queenside_obstruction?
  end 

  def can_castle_kingside?(x)
    rook = find_piece(0, y_position)
    return false unless passes_castle_conditions?(rook)
    no_kingside_obstruction?
  end 

  def castle_kingside
    kingside_rook = find_piece(7, y_position)
    kingside_rook.update_attributes(x_position: 5)           
  end 

  def castle_queenside
    queenside_rook = find_piece(0, y_position)
    queenside_rook.update_attributes(x_position: 3)
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
end
