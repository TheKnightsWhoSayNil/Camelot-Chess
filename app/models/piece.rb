# Piece will hold all similar logic for all pieces.
class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def legal_move?
    # example of future logic
    # for each piece
  end
end
