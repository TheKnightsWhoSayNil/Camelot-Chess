require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe 'update action' do
    it 'should redirect to game path when piece is moved' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id )
      piece = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 0, y_position: 0)

      put :update, game_id: game.id, id: piece.id, piece: {x_position: 1, y_position: 1}
      
      expect(response).to redirect_to game_path(game)
    end
  end
end
