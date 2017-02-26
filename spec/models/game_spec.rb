require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'update action' do
    it 'adds a player to empty black player slot and redirects to the game' do
      user = create(:user)
      sign_in user
      game = create(:game_white_player)
      patch :update, id: game
      expect(assigns(:game).black_user_id).to eq(user.id)
      expect(response).to redirect_to games_path(game)
    end
  end

  describe 'create action' do
    it 'creates a new game with a white player as the current user, and redirect to games' do
      user = create(:user)
      sign_in user
      post :create, game: { name: 'example game' }
      expect(assigns(:game).white_user_id).to eq(user.id)
      expect(response).to redirect_to(game_path(assigns(:game)))
    end
  end
end
