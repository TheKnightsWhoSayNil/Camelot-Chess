require 'rails_helper'

RSpec.describe Pawn, type: :model do

  describe 'valid_move?' do

    let(:color) { true }
    let(:start_y) { 1 }
    let(:pawn) { Pawn.create(color: color, x_position: 1, y_position: start_y) }

    context 'a white pawn' do
      it 'be a valid move' do
        expect(pawn.valid_move?(1, 2)).to eq(true)
        expect(pawn.valid_move?(1, 3)).to eq(true)
      end

      it 'be an invalid move' do
        expect(pawn.valid_move?(1, 5)).to eq(false)
        expect(pawn.valid_move?(2, 1)).to eq(false)
        expect(pawn.valid_move?(99, 99)).to eq(false)
      end
    end

    context 'a black pawn' do

      let(:color) { false }
      let(:start_y) { 6 }

      it 'be a valid move' do
        expect(pawn.valid_move?(1, 5)).to eq(true)
        expect(pawn.valid_move?(1, 4)).to eq(true)
      end
    end
  end
end