require 'rails_helper'

RSpec.describe Knight, type: :model do
  let(:game) do
  Game.create(
    white_user: FactoryGirl.create(:user),
    black_user: FactoryGirl.create(:user))
  end

  describe 'valid_move?' do
    context 'knight can move to open squares' do
      it 'be a valid move' do
        game.pieces.delete_all
        knight = Knight.create(color: true, x_position: 1, y_position: 2, game: game)

        expect(knight.valid_move?(2, 0)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        knight = Knight.create(color: true, x_position: 1, y_position: 2, game: game)

        expect(knight.valid_move?(3, 1)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        knight = Knight.create(color: true, x_position: 1, y_position: 2, game: game)

        expect(knight.valid_move?(3, 3)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        knight = Knight.create(color: true, x_position: 1, y_position: 2, game: game)

        expect(knight.valid_move?(2, 4)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        knight = Knight.create(color: true, x_position: 1, y_position: 2, game: game)

        expect(knight.valid_move?(0, 4)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        knight = Knight.create(color: true, x_position: 1, y_position: 2, game: game)

        expect(knight.valid_move?(0, 0)).to eq(true)
      end

      it 'be a valid move' do
        game.pieces.delete_all
        knight = Knight.create(color: true, x_position: 1, y_position: 2, game: game)

        expect(knight.valid_move?(2, 5)).to eq(false)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        knight = Knight.create(color: true, x_position: 1, y_position: 2, game: game)

        expect(knight.valid_move?(3, 2)).to eq(false)
      end
    end
  end
end
