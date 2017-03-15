require 'rails_helper'

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
    # it 'should fill_board when game is created' do
      # create_game_with_one_players.fill_board

      # expect(create_game_with_one_players.pieces.count).to eq(16)
    # end

    it 'should fill_board when game is created' do
      create_games_with_two_players.fill_board

      expect(create_games_with_two_players.pieces.count).to eq(32)
    end
  end

  describe 'in_check method' do
    context 'Rook pieces' do
      it 'returns true when opposing piece can capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_rook = Rook.create(x_position: 1, y_position: 2, game_id: board.id, color: 'BLACK', piece_type: 'Rook')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << black_rook
        board.save

        expect(board.in_check?('WHITE')).to eq(true)
      end
      it 'returns false when opposing piece can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_rook = Rook.create(x_position: 7, y_position: 7, game_id: board.id, color: 'BLACK', piece_type: 'Rook')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << black_rook
        board.save

        expect(board.in_check?('WHITE')).to eq(false)
      end
      it 'returns false when same colored piece... can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        white_rook = Rook.create(x_position: 1, y_position: 2, game_id: board.id, color: 'WHITE', piece_type: 'Rook')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << white_rook
        board.save

        expect(board.in_check?('WHITE')).to eq(false)
      end
    end
    context 'Bishop pieces' do
      it 'returns true when opposing piece, bishop, can capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_bishop = Bishop.create(x_position: 2, y_position: 2, game_id: board.id, color: 'BLACK', piece_type: 'Bishop')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << black_bishop
        board.save

        expect(board.in_check?('WHITE')).to eq(true)
      end
      it 'returns false when opposing piece can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_bishop = Bishop.create(x_position: 6, y_position: 7, game_id: board.id, color: 'BLACK', piece_type: 'Bishop')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << black_bishop
        board.save

        expect(board.in_check?('WHITE')).to eq(false)
      end
      it 'returns false when same colored piece... can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        white_bishop = Bishop.create(x_position: 1, y_position: 2, game_id: board.id, color: 'WHITE', piece_type: 'Bishop')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << white_bishop
        board.save

        expect(board.in_check?('WHITE')).to eq(false)
      end
    end
    context 'Knight pieces' do
      it 'returns true when opposing piece, knight, can capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_knight = Knight.create(x_position: 2, y_position: 3, game_id: board.id, color: 'BLACK', piece_type: 'Knight')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << black_knight
        board.save

        expect(board.in_check?('WHITE')).to eq(true)
      end
      it 'returns false when opposing piece can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_knight = Knight.create(x_position: 6, y_position: 7, game_id: board.id, color: 'BLACK', piece_type: 'Knight')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << black_knight
        board.save

        expect(board.in_check?('WHITE')).to eq(false)
      end
      it 'returns false when same colored piece... can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        white_knight = Knight.create(x_position: 1, y_position: 2, game_id: board.id, color: 'WHITE', piece_type: 'Knight')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << white_knight
        board.save

        expect(board.in_check?('WHITE')).to eq(false)
      end
    end
    context 'Queen pieces' do
      it 'returns true when opposing piece, queen, can capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_queen = Queen.create(x_position: 7, y_position: 1, game_id: board.id, color: 'BLACK', piece_type: 'Queen')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << black_queen
        board.save

        expect(board.in_check?('WHITE')).to eq(true)
      end
      it 'returns false when opposing piece, queen, can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        black_queen = Queen.create(x_position: 6, y_position: 0, game_id: board.id, color: 'BLACK', piece_type: 'Queen')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << black_queen
        board.save

        expect(board.in_check?('WHITE')).to eq(false)
      end
      it 'returns false when same colored piece... can not capture king' do
        board = create(:game)
        board.pieces.delete_all

        white_queen = Queen.create(x_position: 1, y_position: 2, game_id: board.id, color: 'WHITE', piece_type: 'Queen')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")

        board.pieces << white_king
        board.pieces << white_queen
        board.save

        expect(board.in_check?('WHITE')).to eq(false)
      end
    end
    context 'Neither in check'
      it 'should return false if both kings are not in check' do
        board = create(:game)
        board.pieces.delete_all

        black_king = King.create(x_position: 3, y_position: 3, game_id: board.id, color: 'BLACK', piece_type: 'King')
        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: 'WHITE', piece_type: "King")
        white_queen = Queen.create(x_position: 0, y_position: 7, game_id: board.id, color: 'WHITE', piece_type: 'Queen')
        black_queen = Queen.create(x_position: 5, y_position: 0, game_id: board.id, color: 'WHITE', piece_type: 'Queen')

        board.pieces << white_king
        board.pieces << black_king
        board.pieces << white_queen
        board.pieces << black_queen

        board.save

        expect(board.in_check?('WHITE')).to eq(false)
        expect(board.in_check?('BLACK')).to eq(false)
      end
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
