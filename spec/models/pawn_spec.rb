require 'rails_helper'
require 'pry'
RSpec.describe Pawn, type: :model do
  let(:game) do
  Game.create(
    white_user: FactoryGirl.create(:user),
    black_user: FactoryGirl.create(:user)
  )
  end

  describe 'PAWN PROMOTION' do
    context 'promotable method' do
      it 'Should show that a pawn is promotable' do
        board = create(:game)
        board.pieces.delete_all

        pawn = Pawn.create(color: 'WHITE', x_position: 0, y_position: 7, game_id: board.id)
        board.pieces << pawn

        expect(pawn.promotable?(0, 7)).to eq(true)
      end

      it 'Should show that a pawn is not promotable' do
        board = create(:game)
        board.pieces.delete_all

        pawn = Pawn.create(color: 'WHITE', x_position: 0, y_position: 6, game_id: board.id)
        board.pieces << pawn

        expect(pawn.promotable?(0, 6)).to eq(false)
      end
    end
    context 'promote! method' do
      it 'Should show the pawn becomes queen once promoted' do
        board = create(:game)
        board.pieces.delete_all

        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 7, game_id: board.id)
        board.pieces << pawn

        pawn.promote!(1,7)
        pawn.reload
        expect(pawn.x_position).to eq(nil)
        expect(pawn.y_position).to eq(nil)
        expect(board.pieces.find_by(x_position: 1, y_position: 7).piece_type).to eq("Queen")
        expect(board.pieces.find_by(x_position: 1, y_position: 7).color).to eq("WHITE")
      end
    end
    context 'valid move of white pawn using move_to method' do
      it 'can be promoted when moving to y_position: 7' do
        board = create(:game)
        board.pieces.delete_all

        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 6, game_id: board.id)

        board.pieces << pawn
        pawn.move_to!(1, 7)
        pawn.reload

        expect(pawn.x_position).to eq(nil)
        expect(pawn.y_position).to eq(nil)
        expect(board.pieces.find_by(x_position: 1, y_position: 7).piece_type).to eq("Queen")
      end
      it 'can be promoted when moving to y_position: 0' do
        board = create(:game)
        board.pieces.delete_all

        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 1, game_id: board.id, user_turn: "BLACK")
        binding.pry
        board.pieces << pawn
        pawn.move_to!(1, 0)
        pawn.reload

        expect(pawn.x_position).to eq(nil)
        expect(pawn.y_position).to eq(nil)
        expect(board.pieces.find_by(x_position: 1, y_position: 0).piece_type).to eq("Queen")
        expect(board.pieces.find_by(x_position: 1, y_position: 0).color).to eq("BLACK")
      end
    end
  end

  describe 'a white pawn' do
    context 'makes a valid move' do
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
    context 'CAPTURE is valid' do
      it 'when the piece is one square diagonally from it' do
        board = create(:game)
        board.pieces.delete_all

        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game_id: board.id)
        rook = Rook.create(color: 'BLACK', x_position: 2, y_position: 2, game_id: board.id)

        board.pieces << pawn
        board.pieces << rook

        pawn.valid_move?(2,2)
        rook.reload
        pawn.reload

        expect(rook.x_position).to eq(nil)
        expect(rook.x_position).to eq(nil)
        expect(pawn.x_position).to eq(2)
        expect(pawn.x_position).to eq(2)
      end
      it 'when the piece is one square diagonally from it' do
        board = create(:game)
        board.pieces.delete_all

        pawn = Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game_id: board.id)
        rook = Rook.create(color: 'BLACK', x_position: 0, y_position: 2, game_id: board.id)

        board.pieces << pawn
        board.pieces << rook

        pawn.valid_move?(0, 2)
        rook.reload
        pawn.reload

        expect(rook.x_position).to eq(nil)
        expect(rook.x_position).to eq(nil)
        expect(pawn.x_position).to eq(0)
        expect(pawn.y_position).to eq(2)
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
    context 'CAPTURE move' do
      it 'when the piece is one square diagonally from it' do
        game.pieces.delete_all

        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        rook = Rook.create(color: 'WHITE', x_position: 0, y_position: 5, game: game)

        game.pieces << pawn
        game.pieces << rook

        pawn.valid_move?(0, 5)
        pawn.reload
        rook.reload

        expect(rook.x_position).to eq(nil)
        expect(rook.x_position).to eq(nil)
        expect(pawn.x_position).to eq(0)
        expect(pawn.y_position).to eq(5)
      end
      it 'when the piece is one square diagonally from it' do
        game.pieces.delete_all

        pawn = Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game)
        rook = Rook.create(color: 'WHITE', x_position: 2, y_position: 5, game: game)

        game.pieces << pawn
        game.pieces << rook

        pawn.valid_move?(2, 5)
        pawn.reload
        rook.reload

        expect(rook.x_position).to eq(nil)
        expect(rook.x_position).to eq(nil)
        expect(pawn.x_position).to eq(2)
        expect(pawn.y_position).to eq(5)
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
end
