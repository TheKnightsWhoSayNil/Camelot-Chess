require 'rails_helper'
require 'pry'
RSpec.describe Game, type: :model do
  describe 'SCOPES' do
    context 'Game.available' do
      it 'shows the available games' do
        create_games_with_two_players
        available1 = create_game_with_one_players
        available2 = create_game_with_one_players

        expect(Game.available).to match_array [available1, available2]
      end
      it 'shows no games when there are none available' do
        create_games_with_two_players

        expect(Game.available).to eq []
      end
    end
  end

  describe 'fill_board method' do
    it 'should fill_board when game is created' do
      create_games_with_two_players.fill_board

      expect(create_games_with_two_players.pieces.count).to eq(32)
    end
  end

  describe 'in_check method' do
    context 'Rook pieces' do
      it 'True when opposing piece can capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_rook = Rook.create(x_position: 0, y_position: 7, game_id: board.id, color: 'BLACK', piece_type: 'Rook')
        white_king = King.create(x_position: 0, y_position: 0, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << black_rook

        expect(board.in_check?('WHITE')).to eq(true)
      end
      it 'False when opposing piece can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_rook = Rook.create(x_position: 7, y_position: 7, game_id: board.id, color: 'BLACK', piece_type: 'Rook')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << black_rook

        expect(board.in_check?('WHITE')).to eq(false)
      end
      it 'False when same colored piece... can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        white_rook = Rook.create(x_position: 1, y_position: 2, game_id: board.id, color: 'WHITE', piece_type: 'Rook')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << white_rook

        expect(board.in_check?('WHITE')).to eq(false)
      end
    end
    context 'Bishop pieces' do
      it 'True when opposing piece, bishop, can capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_bishop = Bishop.create(x_position: 3, y_position: 3, game_id: board.id, color: 'BLACK', piece_type: 'Bishop')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << black_bishop

        expect(board.in_check?('WHITE')).to eq(true)
      end
      it 'False when opposing piece can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_bishop = Bishop.create(x_position: 6, y_position: 7, game_id: board.id, color: 'BLACK', piece_type: 'Bishop')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << black_bishop

        expect(board.in_check?('WHITE')).to eq(false)
      end
      it 'returns false when same colored piece... can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        white_bishop = Bishop.create(x_position: 1, y_position: 2, game_id: board.id, color: 'WHITE', piece_type: 'Bishop')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << white_bishop

        expect(board.in_check?('WHITE')).to eq(false)
      end
    end
    context 'Knight pieces' do
      it 'True when opposing piece, knight, can capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_knight = Knight.create(x_position: 2, y_position: 3, game_id: board.id, color: 'BLACK', piece_type: 'Knight')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << black_knight

        expect(board.in_check?('WHITE')).to eq(true)
      end
      it 'False when opposing piece can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_knight = Knight.create(x_position: 6, y_position: 7, game_id: board.id, color: 'BLACK', piece_type: 'Knight')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << black_knight

        expect(board.in_check?('WHITE')).to eq(false)
      end
      it 'False when same colored piece... can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        white_knight = Knight.create(x_position: 1, y_position: 2, game_id: board.id, color: 'WHITE', piece_type: 'Knight')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << white_knight

        expect(board.in_check?('WHITE')).to eq(false)
      end
    end
    context 'Queen pieces' do
      it 'True when opposing piece, queen, can capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_queen = Queen.create(x_position: 7, y_position: 1, game_id: board.id, color: 'BLACK', piece_type: 'Queen')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << black_queen

        expect(board.in_check?('WHITE')).to eq(true)
      end
      it 'False when opposing piece, queen, can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_queen = Queen.create(x_position: 6, y_position: 0, game_id: board.id, color: 'BLACK', piece_type: 'Queen')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << black_queen

        expect(board.in_check?('WHITE')).to eq(false)
      end
      it 'False when same colored piece... can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        white_queen = Queen.create(x_position: 1, y_position: 2, game_id: board.id, color: 'WHITE', piece_type: 'Queen')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: 'King')

        board.pieces << white_king
        board.pieces << white_queen

        expect(board.in_check?('WHITE')).to eq(false)
      end
    end
    context 'Neither in check' do
      it 'False if both kings are not in check' do
        board = create(:game)
        board.pieces.delete_all

        black_king = King.create(x_position: 0, y_position: 0, game_id: board.id, color: 'BLACK', piece_type: 'King')
        white_king = King.create(x_position: 0, y_position: 7, game_id: board.id, color: 'WHITE', piece_type: 'King')
        white_queen = Queen.create(x_position: 2, y_position: 7, game_id: board.id, color: 'WHITE', piece_type: 'Queen')
        black_queen = Queen.create(x_position: 5, y_position: 0, game_id: board.id, color: 'BLACK', piece_type: 'Queen')

        board.pieces << white_king
        board.pieces << black_king
        board.pieces << white_queen
        board.pieces << black_queen

        expect(board.in_check?('WHITE')).to eq(false)
        expect(board.in_check?('BLACK')).to eq(false)
      end
      it 'should return false if both kings are not in check' do
        board = create_games_with_two_players

        expect(board.in_check?('WHITE')).to eq(false)
        expect(board.in_check?('BLACK')).to eq(false)
      end
    end
    context 'Both in check' do
      it 'True if both kings are not in check' do
        board = create(:game)
        board.pieces.delete_all

        black_king = King.create(x_position: 0, y_position: 0, game_id: board.id, color: 'BLACK', piece_type: 'King')
        white_king = King.create(x_position: 0, y_position: 7, game_id: board.id, color: 'WHITE', piece_type: 'King')
        white_queen = Queen.create(x_position: 2, y_position: 0, game_id: board.id, color: 'WHITE', piece_type: 'Queen')
        black_queen = Queen.create(x_position: 5, y_position: 7, game_id: board.id, color: 'BLACK', piece_type: 'Queen')

        board.pieces << white_king
        board.pieces << black_king
        board.pieces << white_queen
        board.pieces << black_queen

        expect(board.in_check?('WHITE')).to eq(true)
        expect(board.in_check?('BLACK')).to eq(true)
      end
    end
    context 'Pieces blocking from being in Check' do
      it 'False if king has a piece blocking it from being capured' do
        board = create(:game)
        board.pieces.delete_all

        black_king = King.create(x_position: 0, y_position: 0, game_id: board.id, color: 'BLACK', piece_type: 'King')
        black_pawn = Pawn.create(x_position: 1, y_position: 0, game_id: board.id, color: 'BLACK', piece_type: 'Pawn')
        black_pawn = Pawn.create(x_position: 2, y_position: 0, game_id: board.id, color: 'BLACK', piece_type: 'Pawn')
        white_rook = Rook.create(x_position: 7, y_position: 0, game_id: board.id, color: 'WHITE', piece_type: 'Rook')

        board.pieces << white_rook
        board.pieces << black_king
        board.pieces << black_pawn
        board.pieces << black_pawn

        expect(board.in_check?('BLACK')).to eq(false)
      end
    end
  end

  describe 'capture_opponent_causing_check?' do
    it 'True if WHITE king enemies causing check are capturable' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 3, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('WHITE')).to eq true
      expect(board.send(:capture_opponent_causing_check?, 'WHITE')).to eq true
    end

    it 'True if BLACK king enemies causing check are capturable' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 5, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('BLACK')).to eq true
      expect(board.send(:capture_opponent_causing_check?, 'BLACK')).to eq true
    end

    it 'False if WHITE king enemies causing check are not capturable' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 6, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('WHITE')).to eq true
      expect(board.send(:capture_opponent_causing_check?, 'WHITE')).to eq false
    end

    it 'False if BLACK king enemies causing check are not capturable' do
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

  describe 'can_i_move_out_of_check?' do
    it 'True if WHITE king i_can_move_out_of_check' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 5, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('WHITE')).to eq true
      expect(board.send(:i_can_move_out_of_check?, 'WHITE')).to eq true
    end

    it 'True if BLACK king i_CANT_move_out_of_check' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 5, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('BLACK')).to eq true
      expect(board.send(:i_can_move_out_of_check?, 'BLACK')).to eq true
    end

    it 'False if WHITE king can not_move_out_of_check' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 5, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'Queen')
      queen2 = Queen.new(x_position: 5, y_position: 5, color: 'BLACK', game_id: board.id, piece_type: 'Queen')
      queen3 = Queen.new(x_position: 5, y_position: 3, color: 'BLACK', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << queen2
      board.pieces << queen3
      board.pieces << king

      expect(board.in_check?('WHITE')).to eq true
      expect(board.send(:i_can_move_out_of_check?, 'WHITE')).to eq false
    end

    it 'Expect king position attributes to update to original x_position, y_position' do
      board = create(:game)
      board.pieces.delete_all

      king = King.new(x_position: 4, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'King')
      queen = Queen.new(x_position: 5, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'Queen')

      board.pieces << queen
      board.pieces << king

      expect(board.in_check?('WHITE')).to eq true
      expect(board.send(:i_can_move_out_of_check?, 'WHITE')).to eq true
      expect(king.x_position).to eq 4
      expect(king.y_position).to eq 4
    end
  end

  describe 'stalemate?' do
      it 'white king has no valid moves and stalemate is true' do
        board = create(:game)
        board.pieces.delete_all

        king = King.new(x_position: 4, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'King')
        rook = Rook.new(x_position: 3, y_position: 1, color: 'BLACK', game_id: board.id, piece_type: 'Rook')
        rook1 = Rook.new(x_position: 5, y_position: 1, color: 'BLACK', game_id: board.id, piece_type: 'Rook')
        rook2 = Rook.new(x_position: 1, y_position: 3, color: 'BLACK', game_id: board.id, piece_type: 'Rook')
        rook3 = Rook.new(x_position: 1, y_position: 5, color: 'BLACK', game_id: board.id, piece_type: 'Rook')

        board.pieces << rook
        board.pieces << rook1
        board.pieces << rook2
        board.pieces << rook3
        board.pieces << king

        expect(board.stalemate?('WHITE')).to eq(true)
      end

      it 'black king has no valid moves and stalemate is true' do
        board = create(:game)
        board.pieces.delete_all

        king = King.new(x_position: 4, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'King')
        rook = Rook.new(x_position: 3, y_position: 1, color: 'WHITE', game_id: board.id, piece_type: 'Rook')
        rook1 = Rook.new(x_position: 5, y_position: 1, color: 'WHITE', game_id: board.id, piece_type: 'Rook')
        rook2 = Rook.new(x_position: 1, y_position: 3, color: 'WHITE', game_id: board.id, piece_type: 'Rook')
        rook3 = Rook.new(x_position: 1, y_position: 5, color: 'WHITE', game_id: board.id, piece_type: 'Rook')

        board.pieces << rook
        board.pieces << rook1
        board.pieces << rook2
        board.pieces << rook3
        board.pieces << king

        expect(board.stalemate?('BLACK')).to eq(true)
      end

      it 'white king has valid moves and stalemate is false' do
        board = create(:game)
        board.pieces.delete_all

        king = King.new(x_position: 4, y_position: 4, color: 'WHITE', game_id: board.id, piece_type: 'King')
        rook = Rook.new(x_position: 2, y_position: 1, color: 'BLACK', game_id: board.id, piece_type: 'Rook')
        rook1 = Rook.new(x_position: 5, y_position: 1, color: 'BLACK', game_id: board.id, piece_type: 'Rook')
        rook2 = Rook.new(x_position: 1, y_position: 3, color: 'BLACK', game_id: board.id, piece_type: 'Rook')
        rook3 = Rook.new(x_position: 1, y_position: 5, color: 'BLACK', game_id: board.id, piece_type: 'Rook')

        board.pieces << rook
        board.pieces << rook1
        board.pieces << rook2
        board.pieces << rook3
        board.pieces << king

        expect(board.stalemate?('WHITE')).to eq(false)
      end

      it 'black king has valid moves and stalemate is false' do
        board = create(:game)
        board.pieces.delete_all

        king = King.new(x_position: 4, y_position: 4, color: 'BLACK', game_id: board.id, piece_type: 'King')
        rook = Rook.new(x_position: 2, y_position: 1, color: 'WHITE', game_id: board.id, piece_type: 'Rook')
        rook1 = Rook.new(x_position: 5, y_position: 1, color: 'WHITE', game_id: board.id, piece_type: 'Rook')
        rook2 = Rook.new(x_position: 1, y_position: 3, color: 'WHITE', game_id: board.id, piece_type: 'Rook')
        rook3 = Rook.new(x_position: 1, y_position: 5, color: 'WHITE', game_id: board.id, piece_type: 'Rook')

        board.pieces << rook
        board.pieces << rook1
        board.pieces << rook2
        board.pieces << rook3
        board.pieces << king

        expect(board.stalemate?('BLACK')).to eq(false)
      end
    end


  def create_game_with_no_pieces
    board = create(:game)
    board.pieces.delete_all
  end


  def create_game_with_one_players
    player_1 = FactoryGirl.create(:user)
    Game.create(white_user: player_1)
  end

  def create_games_with_two_players
    player_1 = FactoryGirl.create(:user)
    player_2 = FactoryGirl.create(:user)
    Game.create(white_user: player_1, black_user: player_2)
  end
end
