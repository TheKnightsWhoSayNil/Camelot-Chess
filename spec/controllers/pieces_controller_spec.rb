require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe 'update action' do
    it 'should redirect to game path when piece is moved' do
        @game = create(:game)
        pawn = @game.pieces.where(game_id: @game.id, piece_type: 'Pawn', color: 'WHITE', x_position: 1, y_position: 1).take

        patch :update, game_id: @game.id, id: pawn.id, piece: {x_position: 2, y_position: 1, color: 'WHITE'}

        expect(response).to have_http_status :success
    end
    it 'should redirect to game path when piece is moved' do
        @game = create(:game)
        pawn = @game.pieces.where(game_id: @game.id, piece_type: 'Pawn', color: 'WHITE', x_position: 1, y_position: 1).take

        patch :update, game_id: @game.id, id: pawn.id, piece: {x_position: 1, y_position: 1, color: 'WHITE'}

        expect(response).to have_http_status :success
    end

  end
end
