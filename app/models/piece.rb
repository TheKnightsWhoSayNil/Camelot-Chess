# Piece will hold all similar logic for all pieces.
class Piece < ApplicationRecord
   belongs_to :game
   belongs_to :user

  def initialize (x_position, y_position)
    @x_position = self.x_position
    @y_position = self.y_position
    @x_end = end[0]
    @y_end = end[1]
  end

  def within_chessboard?(x, y)
    return true if x >= 0 && y >= 0 && x <= 7 && y <= 7
  end
  # should store all the possible diagonal moves 
  # excluding starting position hence "if x > 0"
  def diagonal_moves
      coordinates = []
      8.times do |x|
        if x > 0 
        coordinates << [x, x]
        coordinates << [x, -x]
        coordinates << [-x, x]
        coordinates << [-x, -x]
        end
      end
      return coordinates   
  end

  def diagonal_valid_moves(x_position, y_position)
    valid_move_coordinates = []
    diagonal_moves.each do |x, y|
      if within_chessboard?(x_position + x, y_position + y)
        valid_move_coordinates << [(x_position + x), (y_position + y)]
      end
    end
    return valid_move_coordinates   
  end

 def horizontal_moves
    coordinates = []
      8.times do |x|
        if x > 0 
        coordinates << [x, 0]
        coordinates << [-x, 0]
        end
      end
      return coordinates
  end

  def horizontal_valid_moves(x_position, y_position)
    valid_move_coordinates = []
    horizontal_moves.each do |x, y|
      if within_chessboard?(x_position + x, y_position + y)
        valid_move_coordinates << [(x_position + x), (y_position + y)]
      end
    end
    return valid_move_coordinates
  end

  def vertical_moves
    coordinates = []
      8.times do |y|
        if y > 0 
        coordinates << [0, y]
        coordinates << [0, -y]
        end
      end
      return coordinates
  end

  def vertical_valid_moves(x_position, y_position)
    valid_move_coordinates = []
    vertical_moves.each do |x, y|
      if within_chessboard?(x_position + x, y_position + y)
        valid_move_coordinates << [(x_position + x), (y_position + y)]
      end
    end
    return valid_move_coordinates
  end


  def is_obstructed?
    path = check_path(x_position, y_position, x_end, y_end)
    # movement: right to left
    if path == 'horizontal' && x_position < x_end 
      (x_position + 1).upto(x_end - 1) do |x|
        return true if space_occupied?(x, y_position)
      end
    end
    # movement: left to right
    if path == 'horizontal' && x_position > x_end
      (x_position - 1).downto(x_end + 1) do |x|
        return true if space_occupied?(x, y_position)
      end
    end
    # path is vertical down
    if path == 'vertical' && y_position < y_end
      (y_position + 1).upto(y_end - 1) do |y|
        return true if space_occupied?(x_position, y)
      end
    end
    # path is vertical up
    if path == 'vertical' && y_position > y_end
      (y_position - 1).downto(y_end + 1) do |y|
        return true if space_occupied?(x_position, y)
      end
    end
    if path == 'horizontal' || path == 'vertical'
      return false
    end
    # path is diagonal and down
    if @diagonal.abs == 1.0 && x_position < x_end
      (x_position + 1).upto(x_end - 1) do |x|
        delta_y = x - x_position
        y = y_end > y_position ? y_position + delta_y : y_position - delta_y
        return true if space_occupied?(x, y)
      end
    end
    # path is diagonal and up
    if @diagonal.abs == 1.0 && x_position > x_end
      (x_position - 1).downto(x_end + 1) do |x|
        delta_y = x_position - x
        y = y_end > y_position ? y_position + delta_y : y_position - delta_y
        return true if space_occupied?(x, y)
      end
    end
    # path is not a straight line
    if @diagonal.abs != 1.0
      fail 'path is not a straight line'
    else return false
    end
  end

  def space_occupied?(x, y)
    game.pieces.where(x_position: x, y_position: y)
  end

  def check_path(x_position, y_position, x_end, y_end)
    if y_position == y_end
      return 'horizontal'
    elsif x_position == x_end
      return 'vertical'
    else
      @diagonal = (y_end - y_position).to_f / (x_end - x_position).to_f
    end
  end

end

