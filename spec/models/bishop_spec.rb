require 'rails_helper'

RSpec.describe Bishop, type: :model do

  describe 'valid_move?' do
    bishop = Bishop.create(color: true, x_position: 4, y_position: 4)

    it 'returns false if moves vertically' do
      expect(bishop.valid_move?(4,6)).to eq false
    end

    it 'returns false if moves horizontally' do
      expect(bishop.valid_move?(1,4)).to eq false
    end

    it 'returns true if moving diagonally' do
      expect(bishop.valid_move?(7,7)).to eq true
    end
  end
end
