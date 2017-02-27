# /app/models/pawn.rb
class Pawn < Piece
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
end
