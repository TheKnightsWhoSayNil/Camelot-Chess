require 'rails_helper'

RSpec.describe Rook, type: :model do

  describe 'valid_move?' do

    rook = Rook.create(color: true, x_position: 4, y_position: 4)

    it 'returns true if moving 2 spaces vertically' do 
      expect(rook.valid_move?(4,6)).to eq(true)
    end 

    it 'returns true if moving horizontally' do
      expect(rook.valid_move?(8,4)).to eq(true)
    end 

    it 'returns false if trying to move diagonally' do
      expect(rook.valid_move?(7,7)).to eq(false)
    end 

  end 

end 
