# Piece will hold all similar logic for all pieces.
class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def initialize(x_position, y_position)
    @x_position = x_position
    @y_position = y_position
    @x_end = x_end
    @y_end = y_end
  end

  def legal_move?(x_position, y_position)
    ##
  end

  def is_obstructed?(x_end, y_end)
    if horizontal? || vertical? # if y_position hasn't changed
      move
      if space_occupied?
        # logic
        return true
      else
        return false
      end
    end
    if diagonal?
      spaces_moved = self.diagonal?
      self.spaces_moved

  end

  def move(x_position, y_position)
    if horizontal?
      x_end - self(x_position)
    elsif vertical?
      y_end - self(y_position)
    else
      self(x_position) && self(y_position) + x(n) && y(n)
    end
  end

  def space_occupied?
    # logic
  end



  private

  def horizontal?
    y_end == self.y_position
  end

  def vertical?
    x_end == self.x_position
  end

  def diagonal?
    (x_end.to_i - self.x_end.to_i).abs == (y_end.to_i - self.y_end.to_i).abs
  end

  def x_end(x_position, y_position)
    
  end

end
