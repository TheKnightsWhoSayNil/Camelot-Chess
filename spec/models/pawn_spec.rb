require 'rails_helper'

RSpec.describe Pawn, type: :model do
  let(:game) do
  Game.create(
    white_user: FactoryGirl.create(:user),
    black_user: FactoryGirl.create(:user))
  end

  def create_game_with_one_black_pawn
    Pawn.create(color: 'BLACK', x_position: 1, y_position: 6, game: game, piece_type: 'Pawn')
  end

  def create_game_with_one_white_pawn
    Pawn.create(color: 'WHITE', x_position: 1, y_position: 1, game: game, piece_type: 'Pawn')
  end

  def create_bishop_to_be_captured
   Bishop.create(color: 'BLACK', x_position: 0, y_position: 2, game: game, piece_type: 'Bishop')
  end

  def create_knight_to_be_captured
  Knight.create(color: 'BLACK', x_position: 2, y_position: 2, game: game, piece_type: 'Knight')
  end



  describe 'a white pawns' do
    context 'a valid move' do
      it 'can move one space forward' do
        pawn = create_game_with_one_white_pawn
        expect(pawn.valid_move?(1, 2)).to eq(true)
      end
      it 'can move two spaces forward' do
        pawn = create_game_with_one_white_pawn
        expect(pawn.valid_move?(1, 3)).to eq(true)
      end
    end
    context 'invalid move' do
      it 'can not move forward more than 2 spaces' do
        pawn = create_game_with_one_white_pawn
        expect(pawn.valid_move?(1, 5)).to eq(false)
      end
      it 'can not move horizontally' do
        pawn = create_game_with_one_white_pawn
        expect(pawn.valid_move?(2, 1)).to eq(false)
      end
      it 'the pawn can not spaz out' do
        pawn = create_game_with_one_white_pawn
        expect(pawn.valid_move?(99, 99)).to eq(false)
      end
    end
    context 'can make a valid capture move' do
      it 'when the piece is one square diagonally from it' do
        pawn = create_game_with_one_white_pawn
        bishop = create_bishop_to_be_captured
        expect(pawn.valid_move?(0, 2)).to eq(true)
        expect(bishop.capture_piece_at!(0, 2)).to eq(bishop.x_position = nil, bishop.y_position = nil)
      end
      it 'when the piece is one square diagonally from it' do
        pawn = create_game_with_one_white_pawn
        knight = create_knight_to_be_captured
        expect(pawn.valid_move?(2, 2)).to eq(true)
        expect(knight.capture_piece_at!(2, 2)).to eq(knight.x_position = nil, knight.y_position = nil)
      end
    end
  end
  describe 'a black pawn' do
    context 'valid moves' do
      it 'moves one square forward' do
        pawn = create_game_with_one_black_pawn
        expect(pawn.valid_move?(1, 5)).to eq(true)
      end
      it 'moves two squares forward' do
        pawn = create_game_with_one_black_pawn
        expect(pawn.valid_move?(1, 4)).to eq(true)
      end
    end
    context 'invalid moves' do
      it 'can not move forward more than 2 spaces' do
        pawn = create_game_with_one_black_pawn
        expect(pawn.valid_move?(1, 3)).to eq(false)
      end
      it 'can not move horizontally' do
        pawn = create_game_with_one_black_pawn
        expect(pawn.valid_move?(2, 6)).to eq(false)
      end
      it 'the pawn has officially lost its mind' do
        pawn = create_game_with_one_black_pawn
        expect(pawn.valid_move?(99, 99)).to eq(false)
      end
    end
    context 'can make a valid capture move' do
      it 'when the piece is one square diagonally from it' do
        pawn = create_game_with_one_black_pawn
        expect(pawn.valid_move?(2, 5)).to eq(true)
      end
      it 'when the piece is one square diagonally from it' do
        pawn = create_game_with_one_black_pawn
        expect(pawn.valid_move?(0, 5)).to eq(true)
      end
    end

    context 'cant make a valid move if obstructed' do
      it 'when a piece is in the way in front' do
        game.pieces.delete_all
        pawn = Pawn.create(color: 'WHITE', x_position: 0, y_position: 0, game: game)
        rook = Pawn.create(color: 'BLACK', x_position: 0, y_position: 1, game: game)

        expect(pawn.valid_move?(0,2)).to eq false
      end
    end
  end
end
