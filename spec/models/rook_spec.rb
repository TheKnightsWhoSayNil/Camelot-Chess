require 'rails_helper'
require 'pry'
RSpec.describe Rook, type: :model do
  let(:game) do
  Game.create(
    white_user: FactoryGirl.create(:user),
    black_user: FactoryGirl.create(:user))
  end

  def create_game_with_one_white_rook
    rook = Rook.create(color: 'WHITE', x_position: 4, y_position: 4, game: game)
  end

  describe 'valid_move?' do
    context 'regular moves' do
      it 'returns true if moving 2 spaces vertically' do
        game.pieces.delete_all
        rook = create_game_with_one_white_rook
        expect(rook.valid_move?(4,6)).to eq(true)
      end

      it 'returns true if moving left horizontally' do
        game.pieces.delete_all
        rook = create_game_with_one_white_rook
        expect(rook.valid_move?(1,4)).to eq(true)
      end

      it 'returns true if moving right horizontally' do
        game.pieces.delete_all
        rook = create_game_with_one_white_rook
        expect(rook.valid_move?(5,4)).to eq(true)
      end

      it 'returns false if trying to move diagonally' do
        game.pieces.delete_all
        rook = create_game_with_one_white_rook
        expect(rook.valid_move?(7,7)).to eq(false)
      end

      it 'returns false if trying to move left diagonally' do
        game.pieces.delete_all
        rook = create_game_with_one_white_rook
        expect(rook.valid_move?(0,0)).to eq(false)
      end
    end
    context 'obstructed moves' do
      it 'returns false if piece is blocking up' do
        game.pieces.delete_all
        rook = Rook.create(color: 'WHITE', x_position: 0, y_position: 0, game: game)
        pawn = Pawn.create(color: 'WHITE', x_position: 0, y_position: 1, game: game)

        expect(rook.valid_move?(0,4)).to eq(false)
      end
      it 'returns false if piece is blocking down' do
        game.pieces.delete_all
        rook = Rook.create(color: 'WHITE', x_position: 0, y_position: 7, game: game)
        pawn = Pawn.create(color: 'WHITE', x_position: 0, y_position: 5, game: game)

        expect(rook.valid_move?(0,1)).to eq(false)
      end
    end
  end
end
