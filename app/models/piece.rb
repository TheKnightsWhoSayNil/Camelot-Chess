# Piece will hold all similar logic for all pieces.
class Piece < ApplicationRecord
   belongs_to :game
   belongs_to :user

  def horizontal_obstruction(x_end, y_end)
    # movement: right to left
    if x_position < x_end 
      (x_position + 1).upto(x_end - 1) do |x|
        return true if space_occupied?(x, y_position)
      end
    end
    # movement: left to right
    if x_position > x_end
      (x_position - 1).downto(x_end + 1) do |x|
        return true if space_occupied?(x, y_position)
      end
    end
  end

  def vertical_obstruction(x_end, y_end)
    # path is vertical down
    if y_position < y_end
      (y_position + 1).upto(y_end - 1) do |y|
        return true if space_occupied?(x_position, y)
      end
    end
    # path is vertical up
    if y_position > y_end
      (y_position - 1).downto(y_end + 1) do |y|
        return true if space_occupied?(x_position, y)
      end
    end
  end

  def diagonal_obstruction(x_end, y_end)
    # path is diagonal and down
    if x_position < x_end
      (x_position + 1).upto(x_end - 1) do |x|
        delta_y = x - x_position
        y = y_end > y_position ? y_position + delta_y : y_position - delta_y
        return true if space_occupied?(x, y)
      end
    end
    # path is diagonal and up
    if x_position > x_end
      (x_position - 1).downto(x_end + 1) do |x|
        delta_y = x_position - x
        y = y_end > y_position ? y_position + delta_y : y_position - delta_y
        return true if space_occupied?(x, y)
      end
    end
  end

  def is_obstructed?(destination)
    x_end = destination[0]
    y_end = destination[1]
    path = check_path(x_position, y_position, x_end, y_end)
    
    if path == 'horizontal'
      return horizontal_obstruction(x_end, y_end)
    end

    if path == 'vertical'
      return vertical_obstruction(x_end, y_end) 
    end

    if path == 'diagonal'
      return diagonal_obstruction(x_end, y_end)
    end
      
    return false
  end

  def space_occupied?(x, y)
    game.pieces.where(x_position: x, y_position: y).present?
  end

  def check_path(x_position, y_position, x_end, y_end)
    if y_position == y_end
      return 'horizontal'
    elsif x_position == x_end
      return 'vertical'
    elsif (y_end - y_position).abs == (x_end - x_position).abs
      return 'diagonal'
    else
      return nil
    end
  end
  
end

