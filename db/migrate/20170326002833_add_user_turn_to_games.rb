class AddUserTurnToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :user_turn, :string
  end
end
