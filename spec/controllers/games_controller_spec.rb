require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe 'update action' do
    it 'adds a player to empty black player slot and redirects to the game' do
      user = FactoryGirl.create(:user)
      sign_in user
      game = create(:game_white_player)

      patch :update, id: game

      expect(assigns(:game).black_user_id).to eq(user.id)
      expect(response).to redirect_to games_path(game)
    end
  end

  describe 'create action' do

    it 'creates a new game with a white player as the current user, and redirect to games' do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, game: { name: 'example game' }

      expect(Game.first.white_user).to eq user
      expect(response).to redirect_to(game_path(Game.first))
    end
  end

end
