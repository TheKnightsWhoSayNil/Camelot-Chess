require 'rails_helper'

RSpec.describe Rook, type: :model do

  describe 'valid_move?' do

    context 'White Rook' do 
      let(:color) { true }
      let(:start_y) { 1 }
      let(:pawn) { Rook.create(color: color, x_position: 1, y_position: start_y) }
      