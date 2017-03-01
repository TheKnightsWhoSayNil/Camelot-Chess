# Game will hold all Game Logic, gameboard etc.
class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces

  
end
