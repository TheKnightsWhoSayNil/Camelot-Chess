# Game will hold all Game Logic, gameboard etc.
class Game < ApplicationRecord
  belongs_to :white_user, class_name: 'User'
  belongs_to :black_user, class_name: 'User', optional: true

  has_many :pieces

  scope :available, ->{ where(black_user_id: nil) }
  # scope :available, ->{ where(black_user_id: nil).or where(white_user_id: nil) }
  #Game.where(black_user_id: nil).or(Game.where(white_user_id: nil))?
end
