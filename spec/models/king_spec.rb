require 'rails_helper'

RSpec.describe King, type: :model do
  let(:game) do
    Game.create(
      white_user: FactoryGirl.create(:user),
      black_user: FactoryGirl.create(:user))
  end

  describe 'king making a valid_move?' do
    context 'valid move within 1 square' do
      it 'be a valid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(3, 6)).to eq(true)
      end
      it 'be a valid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(3, 4)).to eq(true)
      end
      it 'be a valid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(2, 6)).to eq(true)
      end
      it 'be a valid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(2, 5)).to eq(true)
      end
      it 'be a valid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(2, 4)).to eq(true)
      end
      it 'be a valid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(4, 6)).to eq(true)
      end
      it 'be a valid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(4, 5)).to eq(true)
      end
      it 'be a valid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(4, 4)).to eq(true)
      end
    end

    context 'king making an invalid move' do
      it 'be an invalid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(3, 5)).to eq(false)
      end
      it 'be an ivalid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(3, 7)).to eq(false)
      end
      it 'be an ivalid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(3, 8)).to eq(false)
      end
      it 'be an ivalid move' do
        king = King.create(x_position: 3, y_position: 5, game: game)
        expect(king.valid_move?(1, 5)).to eq(false)
      end
    end

    context 'when a piece is obstructing the king' do
      let(:game) do
      Game.create(
        white_user: FactoryGirl.create(:user),
        black_user: FactoryGirl.create(:user))
      end
      it 'when king tries to move over on his own piece, it will stay where its at' do
        game.pieces.delete_all

        king = King.create(x_position: 0, y_position: 0, game: game, color: 'WHITE')
        pawn = Pawn.create(x_position: 0, y_position: 1, game: game, color: 'WHITE')

        king.move_to!(0, 1)
        pawn.reload

        expect(king.x_position).to eq(0)
        expect(king.y_position).to eq(0)

        pawn.reload

        expect(pawn.x_position).to eq(0)
        expect(pawn.y_position).to eq(1)
      end
      it 'returns new coordinates when king captures a piece of the opposite color' do
        game.pieces.delete_all

        king = King.create(x_position: 0, y_position: 0, game: game, color: 'WHITE')
        pawn = Pawn.create(x_position: 0, y_position: 1, game: game, color: 'BLACK')

        king.move_to!(0, 1)
        pawn.reload

        expect(king.x_position).to eq(0)
        expect(king.y_position).to eq(1)

        pawn.reload

        expect(pawn.x_position).to eq(nil)
        expect(pawn.y_position).to eq(nil)
      end
    end
  end

  describe 'castling' do
    context 'valid castle moves' do
      it 'returns true for castling' do
        king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game)
        rook = Rook.create(x_position: 0, y_position: 0, state: 'unmoved', game: game)
        expect(king.can_castle?(2, 0)).to eq(true)
      end
    end
=begin
    context 'invalid castle moves' do
      it 'returns false if has obstructions' do
        king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game)
        rook = Rook.create(x_position: 0, y_position: 0, state: 'unmoved', game: game)
        queen = Queen.create(x_position: 2, y_position: 0, game: game)
        expect(king.can_castle?(2, 0)).to eq(false)
      end
    end
=end
  end
end
