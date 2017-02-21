# Game Migration
class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :game_id
      t.integer :white_user_id
      t.integer :black_user_id
      t.integer :game_winner
      t.integer :game_loser
      t.boolean :draw

      t.timestamps
    end
  end
end
