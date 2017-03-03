require 'rails_helper'

RSpec.describe Knight, type: :model do

  describe 'valid_move?' do
      
    knight = Knight.create(color: true, x_position: 1, y_position: 2)
    
    it 'be a valid move' do
      expect(knight.valid_move?(2, 0)).to eq(true)
      expect(knight.valid_move?(3, 1)).to eq(true)
      expect(knight.valid_move?(3, 3)).to eq(true)
      expect(knight.valid_move?(2, 4)).to eq(true)
      expect(knight.valid_move?(0, 4)).to eq(true)
      expect(knight.valid_move?(0, 0)).to eq(true)          
    end

    it 'be an invalid move' do
      expect(knight.valid_move?(-1, 3)).to eq(false)
      expect(knight.valid_move?(-1, 1)).to eq(false)
      expect(knight.valid_move?(2, 5)).to eq(false)
      expect(knight.valid_move?(3, 2)).to eq(false)
    end
    
  end

end