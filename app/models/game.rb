# Game will hold all Game Logic, gameboard etc.
class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces

  scope :available, ->{ where(black_user_id: nil).or where(white_user_id: nil) }
  #Game.where(black_user_id: nil).or(Game.where(white_user_id: nil))?
end
