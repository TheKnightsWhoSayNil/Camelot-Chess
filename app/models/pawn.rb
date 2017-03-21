# /app/models/pawn.rb
class Pawn < Piece
  def valid_move?(x, y)
    super(x, y)
    if super(x, y)
      if is_capture?(x, y)
        capture_piece_at!(x, y)
        return true
      elsif moving_backward?(y) || (one_square?(x, y) || two_squares?(x, y))
        return false
      end
    end
    super(x, y)
  end

  def in_starting_position?
    if (color == 'WHITE' && y_position == 1) || (color == 'BLACK' && y_position == 6)
      true
    else
      false
    end
  end

  def one_square?(x, y)
    if game.space_occupied?(x, y)
      return true
    end
    !in_starting_position? && ((x - x_position).abs > 0 || (y - y_position).abs > 1)
  end

  def two_squares?(x, y)
    if game.space_occupied?(x, y)
      return true
    end
    in_starting_position? && ((x - x_position). abs > 0 || (y - y_position).abs > 2)
  end

  def is_capture?(x, y)
    if game.space_occupied?(x, y)
      if (y - y_position).abs == 1 && (x - x_position).abs == 1
        true
      end
    else
      false
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

#-----> PAWN PROMOTION <-----#

  # checks to see if pawn is promotable
  def promotable?(y)
    return true if y == 7 && color || y == 0 && !color
    false
  end

  # updates the attributes of pawn  - maybe put in private and rename?
  def promotion(params)
    x = params[:x_position].to_i
    y = params[:y_position].to_i
    type = params[:piece_type]

    # removes pawn from board
    update_attributes(
      x_position: nil,
      y_position: nil,
      state: 'retired-pawn'
    )

    #creates the new piece
    game.pieces.create(
      x_position: x,
      y_position: y,
      piece_type: type,
      state: 'promoted-piece',
      color: color,
    )
  end

  # performs the pawn promotion!
  def promote!(params)
    x = params[:x_position].to_i
    y = params[:y_position].to_i

    if promotable?(y) && valid_move?(x, y)
      promotion(params)
    else
      super(params)
    end
  end
  
end
