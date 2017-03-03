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
    it 'should fill_board when game is created' do
      create_game_with_one_players.fill_board
    end
  end

  def create_games_with_two_players
    player_1 = FactoryGirl.create(:user)
    player_2 = FactoryGirl.create(:user)
    Game.create(white_user: player_1, black_user: player_2)
  end

  def create_game_with_one_players
    player_1 = FactoryGirl.create(:user)
    Game.create(white_user: player_1)
  end
end
