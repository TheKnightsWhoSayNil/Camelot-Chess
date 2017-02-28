require 'rails_helper'

RSpec.describe GamesController, type: :controller do
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
