require 'rails_helper'

RSpec.describe Pawn, type: :model do
  let(:game) do
  Game.create(
    white_user: FactoryGirl.create(:user),
    black_user: FactoryGirl.create(:user))
  end

  describe 'valid_move?' do
    context 'a white pawn' do
      it 'be a valid move' do
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        expect(pawn.valid_move?(1, 2)).to eq(true) unless pawn.is_capture?
      end
      it 'be a valid move' do
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        expect(pawn.valid_move?(1, 3)).to eq(true) unless pawn.is_capture?
      end

      it 'be an invalid move' do
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        expect(pawn.valid_move?(1, 5)).to eq(false)
      end
      it 'be an invalid move' do
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        expect(pawn.valid_move?(2, 1)).to eq(false)
      end
      it 'be an invalid move' do
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        expect(pawn.valid_move?(99, 99)).to eq(false)
      end

      it 'be a valid capture move' do
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        expect(pawn.valid_move?(2, 2)).to eq(true) unless pawn.is_capture? == false
      end
      it 'be a valid capture move' do
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        expect(pawn.valid_move?(0, 2)).to eq(true) unless pawn.is_capture? == false
      end
    end

    context 'a black pawn' do
      it 'be a valid move' do
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        expect(pawn.valid_move?(1, 5)).to eq(true) unless pawn.is_capture?
      end
      it 'be a valid move' do
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        expect(pawn.valid_move?(1, 4)).to eq(true) unless pawn.is_capture?
      end

      it 'be an invalid move' do
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        expect(pawn.valid_move?(1, 3)).to eq(false)
      end
      it 'be an invalid move' do
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        expect(pawn.valid_move?(2, 6)).to eq(false)
      end
      it 'be an invalid move' do
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        expect(pawn.valid_move?(99, 99)).to eq(false)
      end

      it 'be a valid capture move' do
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        expect(pawn.valid_move?(2, 5)).to eq(true) unless pawn.is_capture? == false
      end
      it 'be a valid capture move' do
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        expect(pawn.valid_move?(0, 5)).to eq(true) unless pawn.is_capture? == false
      end
    end
  end
end
