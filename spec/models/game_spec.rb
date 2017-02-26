require 'rails_helper'

RSpec.describe Game, type: :model do

  describe 'SCOPES' do
    describe 'Game.available' do
      it 'shows the available games' do
        create_game_with_two_players
        available1 = create_game_with_one_player
        available2 = create_game_with_one_player

        expect(Game.available).to match_array [available1, available2]
      end
      it 'shows no games when there are none available' do
        create_game_with_two_players

        expect(Game.available).to eq []
      end

    end
  end

  def create_game_with_two_players
    player_1 = FactoryGirl.create(:user)
    player_2 = FactoryGirl.create(:user)
    Game.create(white_user: player_1, black_user: player_2)
  end

  def create_game_with_one_player
    player_1 = FactoryGirl.create(:user)
    Game.create(white_user: player_1)
  end


end
