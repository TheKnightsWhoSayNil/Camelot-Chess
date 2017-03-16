require 'rails_helper'

RSpec.describe Queen, type: :model do

  describe 'valid_move?' do

    queen = Queen.create(color: true, x_position: 4, y_position: 4)

    it 'returns true if moves vertically' do
      expect(queen.valid_move?(4,6)).to eq true
    end

    it 'returns false if moving like a knight' do
      expect(queen.valid_move?(6,5)).to eq false
    end

    it 'returns true if moves diagonally' do
      expect(queen.valid_move?(7,7)).to eq true
    end

    it 'returns true if moves horizontally' do
      expect(queen.valid_move?(1,4)).to eq true
    end
  end
end
