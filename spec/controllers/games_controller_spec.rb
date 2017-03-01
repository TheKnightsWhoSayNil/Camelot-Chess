require 'rails_helper'
require 'byebug'

RSpec.describe GamesController, type: :controller do
  describe 'create action' do
    it 'creates a new game with a white player as the current user, and redirect to games' do
      user = create(:user)
      sign_in user

      post :create, game: { name: 'example game' }

      expect(Game.first.white_user).to eq user
      expect(response).to redirect_to(game_path(Game.first))
    end
  end


  describe 'join action' do
    it 'redirects to game_path after a successful join' do
      game = create_game_with_one_player
      black_user = create(:user)
      sign_in black_user

      patch :join, id: game.id
      expect(response).to redirect_to game_path(game)
    end
    it 'adds a player to empty black player slot' do
      game = create_game_with_one_player
      black_user = create(:user)
      sign_in black_user

      patch :join, id: game.id
      game.reload

      expect(game.black_user).to eq black_user
    end
  end

  def create_game_with_one_player
    player_1 = FactoryGirl.create(:user)
    Game.create(white_user: player_1)
  end
end
