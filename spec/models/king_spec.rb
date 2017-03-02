require 'rails_helper'

RSpec.describe King, type: :model do

  describe 'valid_move?' do
      
    king = King.create(color: true, x_position: 3, y_position: 5)
    
    it 'be a valid move' do
      expect(king.valid_move?(3, 6)).to eq(true)
      expect(king.valid_move?(3, 4)).to eq(true)
      expect(king.valid_move?(2, 6)).to eq(true)
      expect(king.valid_move?(2, 5)).to eq(true)
      expect(king.valid_move?(2, 4)).to eq(true)
      expect(king.valid_move?(4, 6)).to eq(true)  
      expect(king.valid_move?(4, 5)).to eq(true)
      expect(king.valid_move?(4, 4)).to eq(true)    
    end

    it 'be an invalid move' do
      expect(king.valid_move?(3, 5)).to eq(false)
      expect(king.valid_move?(3, 7)).to eq(false)
      expect(king.valid_move?(3, 8)).to eq(false)
      expect(king.valid_move?(1, 5)).to eq(false)
    end
    
  end

end