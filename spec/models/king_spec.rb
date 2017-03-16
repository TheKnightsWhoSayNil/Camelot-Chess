require 'rails_helper'

RSpec.describe King, type: :model do
  let(:game) do 
    Game.create(
      white_user: FactoryGirl.create(:user),
      black_user: FactoryGirl.create(:user))
  end 

  describe 'valid_move?' do
    let(:king) do
      King.create(x_position: 3, y_position: 5, game: game)
    end 
    
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

    it 'be an invalid move', focus: true do 
      expect(king.valid_move?(3, 5)).to eq(false)
      expect(king.valid_move?(3, 7)).to eq(false)
      expect(king.valid_move?(3, 8)).to eq(false)
      expect(king.valid_move?(1, 5)).to eq(false)
    end
  end
  
  describe 'castling' do    
    context 'valid castle moves' do 
      it 'returns true for castling' do
        king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game)
        rook = Rook.create(x_position: 0, y_position: 0, state: 'unmoved', game: game)
        expect(king.can_castle?(2, 0)).to eq(true)
      end 
    end 
=begin    
    context 'invalid castle moves' do 
      it 'returns false if has obstructions' do
        king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game)
        rook = Rook.create(x_position: 0, y_position: 0, state: 'unmoved', game: game)
        queen = Queen.create(x_position: 2, y_position: 0, game: game)
        expect(king.can_castle?(2, 0)).to eq(false)
      end 
    end 
=end 
  end 
end
