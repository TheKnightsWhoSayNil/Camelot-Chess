 # Piece will hold all similar logic for all pieces.
class Piece < ApplicationRecord
   belongs_to :game
   belongs_to :user
   self.inheritance_column = :piece_type

   #just placeholder to accomodate the logic into the valid_move? methods
   #to_be raplaced with the correct method from Tim.
   def is_obstructed?
     false  
   end

   def valid_move?(x, y)
     return false if !within_chessboard?(x, y)
     return false if is_obstructed?
   end

  def self.piece_types
    %w(Pawn Knight Bishop Rook Queen King)
  end

  def within_chessboard?(x, y)
    (x >= 0 && y >= 0 && x <= 7 && y <= 7)
  end
    
end

