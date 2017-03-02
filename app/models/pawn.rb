# /app/models/pawn.rb
class Pawn < Piece

  def valid_move?(x, y)
    super(x, y)

    return false if x_position != x

    if color == true
      distance = 1
      if in_starting_position?
       distance = 2
      end

      return y <= y_position+distance
    else
      distance = -1
    
      if in_starting_position?
        distance = -2
      end

      return y >= y_position+distance
    end
  end


  def in_starting_position?
    if color == true
      y_position == 1
    else
      y_position == 6
    end
  end

  # logic for Pawn specifics
  def start_move(x_position, y_position)
    start_valid_move = []
    if @piece.color && y_position == 1
        start_valid_move << [x_position, y_position + 2]
    elsif @piece.color == false && y_position == 6
        start_valid_move << [x_position, y_position - 2]
    else
      return false
    end
    return start_valid_move
  end

  def single_move(x_position, y_position)
    single_valid_move = []
    if @piece.color
      if within_chessboard?(x_position, y_position + 1)
          single_valid_move << [x_position, y_position + 1]
      end
    elsif @piece.color == false
      if within_chessboard?(x_position, y_position - 1)
        single_valid_move << [x_position, y_position - 1]
      end
    else
      return false
    end
    return single_valid_move
  end

  # this method is determined by a method capture? (tbd)
  # ====================================================
  #def single_vertical_move(x_position, y_position)
  #   single_vertical_move = []
  #     if @piece.color
  #       if within_chessboard?(x_position + 1, y_position + 1)
  #         single_vertical_move << [x_position + 1, y_position + 1]
  #       end
  #       if within_chessboard?(x_position - 1, y_position + 1)
  #         single_vertical_move << [x_position - 1, y_position + 1]
  #       end

  #     elsif @piece.color == false
  #       if within_chessboard?(x_position + 1, y_position - 1)
  #         single_vertical_move << [x_position + 1, y_position - 1]
  #       end
  #       if within_chessboard?(x_position - 1, y_position - 1)
  #         single_vertical_move << [x_position - 1, y_position - 1]
  #       end
  #     else
  #       return false
  #     end
  #     return single_vertical_move
  #   end
  # ===============================================================
        
  
end
