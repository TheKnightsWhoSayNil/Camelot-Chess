require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'SCOPES' do
    describe 'Game.available' do
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

  describe 'in check' do
    it 'returns false if opposing piece can not capture the king in the current state' do
      game = create_games_with_two_players

      expect(game.in_check?('BLACK')).to eq(false)
      # expect(game.in_check?(false)).to eq(false)
    end
    it 'returns true when piece can capture king' do
      game = create_games_with_two_players
      game.pieces.each(&:delete)

      white_king = King.create(x_position: 1, y_position: 1, color: true)
      white_bishop = Bishop.create(x_position: 2, y_position: 2, color: false)

      game.reload

      expect(game.in_check?(true)).to eq true
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
