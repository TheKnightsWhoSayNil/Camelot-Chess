require 'rails_helper'
require 'piece'
require 'pawn'

RSpec.describe Piece, type: :model do

  describe 'diagonal_valid_moves' do
    it 'should successfully render valid diagonal moves' do
      expected = [[0,0], [0,2], [2,0], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]]
      piece = Piece.new(1,1)
      expect(piece.diagonal_valid_moves(1,1).sort).to eq(expected)
    end
  end

  describe 'vertical_valid_moves' do
    it 'should successfully render valid vertical moves' do
      expected = [[1,0], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7]]
      piece = Piece.new(1,1)
      expect(piece.vertical_valid_moves(1,1).sort).to eq(expected)
    end
  end

  describe 'horizontal_valid_moves' do
    it 'should successfully render valid horizontal moves' do
      expected = [[0,1], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1]]
      piece = Piece.new(1,1)
      expect(piece.horizontal_valid_moves(1,1).sort).to eq(expected)
    end
  end

  describe 'start_valid_move' do
    it 'should successfully render pawn valid start move' do
      expected = [[1,3]]
      piece = Piece.new(1,1)
      expect(piece.horizontal_valid_moves(1,1).sort).to eq(expected)
    end
  end
end