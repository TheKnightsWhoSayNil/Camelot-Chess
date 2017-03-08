require 'rails_helper'
require 'piece'

RSpec.describe Piece, type: :model do
  describe 'is_obstructed? method' do
    it 'should return true if obstructed horizontally to the right' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 0, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 1, y_position: 0)

      destination = [2, 0]

      expect(piece.is_obstructed?(destination)).to eq(true)
    end

    it 'should return true if obstructed horizontally to the left' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 2, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 1, y_position: 0)

      destination = [0, 0]

      expect(piece.is_obstructed?(destination)).to eq(true)
    end

    it 'should return true if obstructed vertically from above' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 0, y_position: 2)
      obstruction = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 0, y_position: 1)

      destination = [0, 0]

      expect(piece.is_obstructed?(destination)).to eq(true)
    end

    it 'should return true if obstructed vertically from below' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 0, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 0, y_position: 1)

      destination = [0, 2]

      expect(piece.is_obstructed?(destination)).to eq(true)
    end

    it 'should return true if obstructed diagonally moving down and to the left' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 3, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 2, y_position: 1)

      destination = [1, 2]

      expect(piece.is_obstructed?(destination)).to eq(true)
    end

    it 'should return true if obstructed diagonally moving down and to the right' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 0, y_position: 0)
      obstruction = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 2, y_position: 2)

      destination = [3, 3]

      expect(piece.is_obstructed?(destination)).to eq(true)
    end

    it 'should return true if obstructed diagonally moving up and to the right' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 1, y_position: 3)
      obstruction = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 2, y_position: 2)

      destination = [3, 1]

      expect(piece.is_obstructed?(destination)).to eq(true)
    end

    it 'should return true if obstructed diagonally moving up and to the left' do
      user1 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, white_user_id: user1.id)
      piece = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 3, y_position: 3)
      obstruction = FactoryGirl.create(:piece, game: game, user_id: user1.id, x_position: 2, y_position: 2)

      destination = [1, 1]

      expect(piece.is_obstructed?(destination)).to eq(true)
    end
  end

  describe 'move_to!' do
    context "when the square is unoccupied" do
      it "does allow the move to the new coordinates" do
        board = create(:game)
        board.pieces.delete_all
        king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: true)

        king.move_to!(2, 2)

        expect(king.x_position).to eq(2)
        expect(king.y_position).to eq(2)
      end
    end

    context "when the square is occupied with a piece of the same color" do
      it "does not capture the same colored piece" do
        board = create(:game)
        board.pieces.delete_all

        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: true)
        white_bishop = Bishop.create(x_position: 2, y_position: 2, game_id: board.id, color: true)

        expect(white_king.move_to!(2, 2)).to eq false
      end
    end

    context "when the square is occupied with different colored piece" do
      it "does capture the opponent's piece, and move to the new square" do
        board = create(:game)
        board.pieces.delete_all

        white_king = King.create(x_position: 1, y_position: 1, game_id: board.id, color: true)
        black_bishop = Bishop.create(x_position: 2, y_position: 2, game_id: board.id, color: false)

        white_king.move_to!(2, 2)

        expect(white_king.x_position).to eq(2)
        expect(white_king.y_position).to eq(2)

        black_bishop.reload

        expect(black_bishop.x_position).to eq(nil)
        expect(black_bishop.y_position).to eq(nil)
      end
    end
  end
end

