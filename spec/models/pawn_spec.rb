require 'rails_helper'

RSpec.describe Pawn, type: :model do
  let(:game) do
  Game.create(
    white_user: FactoryGirl.create(:user),
    black_user: FactoryGirl.create(:user)
  )
  end

  # Pawn promotion tests:
  describe 'promotable? method' do
    it 'Should show that a pawn is promotable' do
      create_game_with_promotable_pawn

      expect(@pawn.promotable?(7)).to eq(true)
    end

    it 'Should show that a pawn is not promotable' do
      create_game_with_promotable_pawn

      expect(@pawn.promotable?(6)).to eq(false)
    end
  end

  describe 'promote! method' do
    it 'Should show the pawn becomes queen once promoted' do
      create_game_with_promotable_pawn

      @pawn.promote!(x_position: 1, y_position: 7)
      @pawn.reload
      expect(@pawn.x_position).to eq(nil)
      expect(@pawn.y_position).to eq(nil)
      expect(@game.pieces.find_by(x_position: 1, y_position: 7).piece_type).to eq('Queen')
    end
  end

# Valid move tests
  describe 'white pawn' do
    context 'valid move' do
      it 'can move one space forward' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(1, 2)).to eq(true)
      end
      it 'can move one space forward' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)

        game.pieces << pawn
        pawn.move_to!(1, 2)
        
        expect(pawn.y_position).to eq(2)
      end
      it 'can move two spaces forward' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 0, y_position: 1, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(0, 2)).to eq true
      end
    end
    context 'invalid move' do
      it 'can not move forward more than 2 spaces' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(1, 5)).to eq(false)
      end
      it 'can not move to a square occupied by the same color' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        rook = Rook.create(color: 'WHITE', x_position: 1, y_position: 2, game: game)

        game.pieces << pawn
        game.pieces << rook

        expect(pawn.valid_move?(1, 2)).to eq(false)
      end
      it 'can not move horizontally' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(2, 1)).to eq(false)
      end
      it 'the pawn can not spaz out' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(99, 99)).to eq(false)
      end
    end
    context 'can make a valid capture move' do
      it 'when the piece is one square diagonally from it' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        rook = Rook.create(color: 'BLACK', x_position: 2, y_position: 2, game: game)

        game.pieces << pawn
        game.pieces << rook

        expect(pawn.valid_move?(2, 2)).to eq(true)
      end
      it 'when the piece is one square diagonally from it' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        rook = Rook.create(color: 'BLACK', x_position: 0, y_position: 2, game: game)

        game.pieces << pawn
        game.pieces << rook

        expect(pawn.valid_move?(0, 2)).to eq(true)
      end
    end
    context 'invalid capture move' do
      it 'can not move more than two spaces diagonally' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game)
        rook = Rook.create(color: 'BLACK', x_position: 3, y_position: 3, game: game)

        game.pieces << pawn
        game.pieces << rook

        expect(pawn.valid_move?(3, 3)).to eq(false)
      end
    end
  end
  describe 'black pawn' do
    context 'valid moves' do
      it 'moves one square forward' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 0, y_position: 6, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(0, 5)).to eq(true)
      end
      it 'moves two squares forward' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 0, y_position: 6, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(0, 4)).to eq(true)
      end
    end
    context 'invalid moves' do
      it 'can not move forward more than 2 spaces' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 0, y_position: 6, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(0, 3)).to eq false
      end
      it 'can not move to a square occupied by the same color' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 2, y_position: 6, game: game)
        rook = Rook.create(color: 'BLACK', x_position: 2, y_position: 5, game: game)

        game.pieces << pawn
        game.pieces << rook

        expect(pawn.valid_move?(2, 5)).to eq(false)
      end
      it 'can not move horizontally' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(2, 6)).to eq(false)
      end
      it 'the pawn has officially lost its mind' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)

        game.pieces << pawn

        expect(pawn.valid_move?(99, 99)).to eq(false)
      end
    end
    context 'can make a valid capture move' do
      it 'when the piece is one square diagonally from it' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        rook = Rook.create(color: 'WHITE', x_position: 0, y_position: 5, game: game)

        game.pieces << pawn
        game.pieces << rook

        expect(pawn.valid_move?(0, 5)).to eq(true)
      end
      it 'when the piece is one square diagonally from it' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        rook = Rook.create(color: 'WHITE', x_position: 2, y_position: 5, game: game)

        game.pieces << pawn
        game.pieces << rook

        expect(pawn.valid_move?(2, 5)).to eq(true)
      end
    end

    context 'cant make a valid move if obstructed' do
      it 'when a piece is in the way in front' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 0, y_position: 0, game: game)
        rook = Pawn.create(color: 'WHITE', x_position: 0, y_position: 1, game: game)

        game.pieces << rook
        game.pieces << pawn

        expect(pawn.valid_move?(0, 2)).to eq false
      end

      it 'when a piece is in the way in 1 space in front' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 0, y_position: 1, game: game)
        rook = Pawn.create(color: 'WHITE', x_position: 0, y_position: 2, game: game)

        game.pieces << rook
        game.pieces << pawn

        expect(pawn.valid_move?(0, 2)).to eq false
      end

      it 'when a piece is in the way in 2 spaces in front' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'BLACK', x_position: 0, y_position: 1, game: game)
        rook = Pawn.create(color: 'WHITE', x_position: 0, y_position: 2, game: game)

        game.pieces << rook
        game.pieces << pawn

        expect(pawn.valid_move?(0, 3)).to eq false
      end
    end
  end

  private

  def create_game_with_promotable_pawn
    @game = FactoryGirl.create(:game)
    @game.pieces.find_by(x_position: 1, y_position: 7).destroy
    @game.pieces.find_by(x_position: 2, y_position: 7).destroy
    @pawn = @game.pieces.find_by(x_position: 1, y_position: 1)
    @pawn.update_attributes(y_position: 6)
    @pawn.reload
    @game.pieces.find_by(x_position: 0, y_position: 0).destroy
  end

end
