require 'pry'
class Pawn < Piece
  def valid_move?(x, y)
    if super(x, y)
      if is_capture?(x, y)
        capture_piece_at!(x, y)
        return true
      elsif promotable?(x, y)
        update_attributes(x_position: x, y_position: y)
        promote!(x, y)
      else
        return (one_square?(x, y) || two_squares?(x, y))
      end
    end
    false
  end

  def in_starting_position?
    if (color == 'WHITE' && y_position == 1) || (color == 'BLACK' && y_position == 6)
      true
    else
      false
    end
  end

  def one_square?(x, y)
    unoccupied?(x, y) && (x - x_position).abs == 0 && (y - y_position).abs == 1
  end

  def two_squares?(x, y)
    unoccupied?(x, y) && in_starting_position? && ((x - x_position). abs == 0 && (y - y_position).abs == 2)
  end

  def is_capture?(x, y)
    game.space_occupied?(x, y) && ((y - y_position).abs == 1 && (x - x_position).abs == 1)
  end

#-----> PAWN PROMOTION <-----#

  # checks to see if a pawn is promotable.
  def promotable?(x, y)
    x
    return true if y == 7 && color == "WHITE" || y == 0 && color == "BLACK"
    false
  end

  # performs the pawn promotion by checking to see if the pawn meets the necessary requirements.
  def promote!(x, y)
    if promotable?(x, y)
      piece = piece_at(x, y)
      piece.update_attributes(x_position: nil, y_position: nil)
      piece.reload
      game.pieces.create(piece_type: "Queen", x_position: x, y_position: y, state: 'promoted-piece', color: color)
    else
      false
    end
  end

  private

  def piece_at(x, y)
    game.pieces.find_by(x_position: x, y_position: y)
  end

end
