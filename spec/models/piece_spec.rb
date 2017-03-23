require 'rails_helper'
require 'piece'

RSpec.describe Piece, type: :model do
  describe 'is_obstructed? method' do
    it 'should return true if obstructed horizontally to the right' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 0, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 1, y_position: 0)

      expect(piece.is_obstructed?(2, 2)).to eq(true)
    end

    it 'should return true if obstructed horizontally to the left' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 2, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 1, y_position: 0)

      expect(piece.is_obstructed?(0, 0)).to eq(true)
    end

    it 'should return true if obstructed vertically from above' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 0, y_position: 2)
      obstruction = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 0, y_position: 1)

      expect(piece.is_obstructed?(0, 0)).to eq(true)
    end

    it 'should return true if obstructed vertically from below' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 0, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 0, y_position: 1)

      expect(piece.is_obstructed?(0, 2)).to eq(true)
    end

    it 'should return true if obstructed diagonally moving down and to the left' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 3, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 2, y_position: 1)

      expect(piece.is_obstructed?(1, 2)).to eq(true)
    end

    it 'should return true if obstructed diagonally moving down and to the right' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 0, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 2, y_position: 2)

      expect(piece.is_obstructed?(3, 3)).to eq(true)
    end

    it 'should return true if obstructed diagonally moving up and to the right' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 1, y_position: 3)
      obstruction = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 2, y_position: 2)

      expect(piece.is_obstructed?(3, 1)).to eq(true)
    end

    it 'should return true if obstructed diagonally moving up and to the left' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 3, y_position: 3)
      obstruction = FactoryGirl.create(:piece, game: game, color: 'WHITE', x_position: 2, y_position: 2)

      expect(piece.is_obstructed?(1, 1)).to eq(true)
    end
  end

  describe 'move_to!' do
    let(:game) do
    Game.create(
      white_user: FactoryGirl.create(:user),
      black_user: FactoryGirl.create(:user))
    end
    context "when the square is unoccupied" do
      it "will the move to the new coordinates" do
        game.pieces.delete_all

        queen = Queen.create(x_position: 1, y_position: 1, game: game, color: 'WHITE', piece_type: 'Queen')

        queen.move_to!(2, 2)

        expect(queen.x_position).to eq(2)
        expect(queen.y_position).to eq(2)
      end
      it "will the move to the new coordinates" do
        game.pieces.delete_all

        bishop = Bishop.create(x_position: 0, y_position: 0, game: game, color: 'WHITE', piece_type: 'Bishop')

        bishop.move_to!(7, 7)

        expect(bishop.x_position).to eq(7)
        expect(bishop.y_position).to eq(7)
      end
    end

    context "when the square is occupied with a piece of the same color" do
      it "does not capture the same colored piece" do
        game.pieces.delete_all

        white_king = King.create(x_position: 1, y_position: 1, game: game, color: 'WHITE', piece_type: 'King')
        white_bishop = Bishop.create(x_position: 2, y_position: 2, game: game, color: 'WHITE', piece_type: 'Bishop')

        expect(white_king.move_to!(2, 2)).to eq false
      end
    end

    context "when the square is occupied with different colored piece" do
      it "captures the opponent's piece, and moves to the new square" do
        game.pieces.delete_all

        queen = Queen.create(x_position: 1, y_position: 1, game: game, color: 'WHITE', piece_type: 'Queen')
        black_bishop = Bishop.create(x_position: 1, y_position: 2, game: game, color: 'BLACK', piece_type: 'Bishop')

        queen.move_to!(1, 2)
        black_bishop.reload

        expect(queen.x_position).to eq(1)
        expect(queen.y_position).to eq(2)

        black_bishop.reload

        expect(black_bishop.x_position).to eq(nil)
        expect(black_bishop.y_position).to eq(nil)
      end
    end
  end

  describe "available_moves" do
    describe 'Rook' do
      it 'returns the valid spaces to move to on an empty board' do
        board = create(:game)
        board.pieces.delete_all
        white_rook = Rook.create(x_position: 0, y_position: 0, game_id: board.id, color: 'WHITE')

        result = white_rook.available_moves

        expect(result).to match_array [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
      end
      it 'returns the valid spaces to move to on non-empty board blocked by my own color' do
        board = create(:game)
        board.pieces.delete_all
        white_rook = Rook.create(x_position: 0, y_position: 0, game_id: board.id, color: 'WHITE')
        other_piece = Pawn.create(x_position: 0, y_position: 0, game_id: board.id, color: 'WHITE')

        result = white_rook.available_moves

        expect(result).to match_array [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
      end
      it 'returns the valid spaces to move to on non-empty board blocked by opposing color' do
        board = create(:game)
        board.pieces.delete_all
        white_rook = Rook.create(x_position: 0, y_position: 0, game_id: board.id, color: 'WHITE')
        other_piece = Pawn.create(x_position: 0, y_position: 0, game_id: board.id, color: 'BLACK')

        result = white_rook.available_moves

        expect(result).to match_array [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
      end
    end
  end

  describe 'capture_opponent_causing_check?' do
    it 'True if white king enemies causing check are capturable' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 5, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('WHITE')).to eq true
      expect(board.send(:capture_opponent_causing_check?, 'WHITE')).to eq true
    end

    it 'True if black king enemies causing check are capturable' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 5, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('BLACK')).to eq true
      expect(board.send(:capture_opponent_causing_check?, 'BLACK')).to eq true
    end

    it 'False if white king enemies causing check are not capturable' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 6, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('WHITE')).to eq true
      expect(board.send(:capture_opponent_causing_check?, 'WHITE')).to eq false
    end

    it 'False if black king enemies causing check are not capturable' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 6, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('BLACK')).to eq true
      expect(board.send(:capture_opponent_causing_check?, 'BLACK')).to eq false
    end
  end
  
end
