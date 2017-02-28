# Piece will hold all similar logic for all pieces.
class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def is_obstructed?

  end


end
