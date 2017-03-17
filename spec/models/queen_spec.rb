require 'rails_helper'
require 'pry'

RSpec.describe Queen, type: :model do
  let(:game) do
  Game.create(
    white_user: FactoryGirl.create(:user),
    black_user: FactoryGirl.create(:user))
  end

  describe 'valid_move?' do
    context 'queen moving without any obstructions' do
      it 'returns true if moves vertically' do
        game.pieces.delete_all
        queen = Queen.create(color: 'WHITE', x_position: 4, y_position: 4, game: game)
        expect(queen.valid_move?(4,6)).to eq true
      end

      it 'returns false if moving like a knight' do
        game.pieces.delete_all
        queen = Queen.create(color: 'WHITE', x_position: 4, y_position: 4, game: game)
        expect(queen.valid_move?(6,5)).to eq false
      end

      it 'returns true if moves diagonally' do
        game.pieces.delete_all
        queen = Queen.create(color: 'WHITE', x_position: 4, y_position: 4, game: game)

        expect(queen.valid_move?(7,7)).to eq true
      end

      it 'returns true if moves horizontally' do
        game.pieces.delete_all
        queen = Queen.create(color: 'WHITE', x_position: 4, y_position: 4, game: game)
        expect(queen.valid_move?(1,4)).to eq true
      end
    end
    context 'can not move if piece is in the way' do
      it ' returns false if piece is in the way' do
        game.pieces.delete_all
        queen = Queen.create(color: 'WHITE', x_position: 0, y_position: 0, game: game)
        pawn = Pawn.create(color: 'WHITE', x_position: 0, y_position: 1, game: game)

        expect(queen.valid_move?(0,4)).to eq false
      end
      it ' returns false if piece is in the way' do
        game.pieces.delete_all
        queen = Queen.create(color: 'WHITE', x_position: 0, y_position: 0, game: game)
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        pawn = Pawn.create(color: 'WHITE', x_position: 2, y_position: 2, game: game)
        pawn = Pawn.create(color: 'WHITE', x_position: 3, y_position: 3, game: game)

        expect(queen.valid_move?(7,7)).to eq false
      end
    end
  end
end
