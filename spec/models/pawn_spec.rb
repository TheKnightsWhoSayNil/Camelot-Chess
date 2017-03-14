require 'rails_helper'

RSpec.describe Pawn, type: :model do

  describe 'valid_move?' do

    context 'a white pawn' do

      let(:color) { 'WHITE' }
      let(:start_y) { 1 }
      let(:pawn) { Pawn.create(color: color, x_position: 1, y_position: start_y) }
      
      it 'be a valid move' do
        expect(pawn.valid_move?(1, 2)).to eq(true) unless pawn.is_capture? 
        expect(pawn.valid_move?(1, 3)).to eq(true) unless pawn.is_capture?          
      end

      it 'be an invalid move' do
        expect(pawn.valid_move?(1, 5)).to eq(false)
        expect(pawn.valid_move?(2, 1)).to eq(false)
        expect(pawn.valid_move?(99, 99)).to eq(false)
      end

      it 'be a valid capture move' do
        expect(pawn.valid_move?(2, 2)).to eq(true) unless pawn.is_capture? == false
        expect(pawn.valid_move?(0, 2)).to eq(true) unless pawn.is_capture? == false
       
      end

    end
      
    context 'a black pawn' do

      let(:color) { false }
      let(:start_y) { 6 }
      let(:pawn) { Pawn.create(color: color, x_position: 1, y_position: start_y) }

      it 'be a valid move' do
        expect(pawn.valid_move?(1, 5)).to eq(true) unless pawn.is_capture?
        expect(pawn.valid_move?(1, 4)).to eq(true) unless pawn.is_capture?
      end

      it 'be an invalid move' do
        expect(pawn.valid_move?(1, 3)).to eq(false)
        expect(pawn.valid_move?(2, 6)).to eq(false)
        expect(pawn.valid_move?(99, 99)).to eq(false)
      end

      it 'be a valid capture move' do
        expect(pawn.valid_move?(2, 5)).to eq(true) unless pawn.is_capture? == false
        expect(pawn.valid_move?(0, 5)).to eq(true) unless pawn.is_capture? == false
      end

    end
  
  end

end
