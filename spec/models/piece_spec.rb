require 'rails_helper'
require 'piece'

RSpec.describe Piece, type: :model do

  describe 'is_obstructed? method' do
    it 'should return true if obstructed horizontally' do
      game = FactoryGirl.create(:game)
      piece = FactoryGirl.create(:piece, game: game, x_position: 0, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, x_position: 1, y_position: 0)
      
      destination = [2, 0]

      expect(piece.is_obstructed?(destination)).to eq(true)
    end
  end
end