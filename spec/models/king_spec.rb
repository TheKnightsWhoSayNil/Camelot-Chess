require 'rails_helper'
RSpec.describe King, type: :model do
  let(:game) do
    Game.create(
      white_user: FactoryGirl.create(:user),
      black_user: FactoryGirl.create(:user))
  end

  describe 'king making a valid_move?' do
    context 'valid move within 1 square' do
      it 'be a valid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, game: game, state: 'moved')
        game.pieces << king
        expect(king.valid_move?(3, 6)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, game: game, state: 'moved')
        game.pieces << king
        expect(king.valid_move?(3, 4)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, game: game, state: 'moved')
        game.pieces << king
        expect(king.valid_move?(2, 6)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, game: game, state: 'moved')
        game.pieces << king
        expect(king.valid_move?(2, 5)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, game: game, state: 'moved')
        game.pieces << king
        expect(king.valid_move?(2, 4)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, game: game, state: 'moved')
        game.pieces << king
        expect(king.valid_move?(4, 6)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, game: game, state: 'moved')
        game.pieces << king
        expect(king.valid_move?(4, 5)).to eq(true)
      end
      it 'be a valid move' do
        game.pieces.delete_all
        king = King.create(x_position: 4, y_position: 0, game: game, state: 'unmoved')
        rook = Rook.create(x_position: 4, y_position: 0, game: game, state: 'moved')
        game.pieces << king
        game.pieces << rook
        
        expect(king.valid_move?(4, 1)).to eq(true)
      end
    end

    context 'king making an invalid move' do
      it 'be an invalid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, game: game)
        game.pieces << king
        expect(king.valid_move?(3, 5)).to eq(false)
      end
      it 'be an invalid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, state: 'unmoved', game: game)
        game.pieces << king
        expect(king.valid_move?(3, 7)).to eq(false)
      end
      it 'be an invalid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, game: game)
        game.pieces << king
        expect(king.valid_move?(3, 8)).to eq(false)
      end
      it 'be an invalid move' do
        game.pieces.delete_all
        king = King.create(x_position: 3, y_position: 5, state: 'moved', game: game)
        king.reload
        expect(king.valid_move?(1, 5)).to eq(false)
      end
      it 'be an invalid move' do
        king = King.create(x_position: 3, y_position: 5, state: 'moved', game: game)
        expect(king.valid_move?(5, 5)).to eq(false)
      end
    end

    context 'when a piece is obstructing the king' do
      let(:game) do
      Game.create(
        white_user: FactoryGirl.create(:user),
        black_user: FactoryGirl.create(:user))
      end
      it 'when king tries to move over on his own piece, it will stay where its at' do
        game.pieces.delete_all

        king = King.create(x_position: 0, y_position: 0, game: game, color: 'WHITE')
        pawn = Pawn.create(x_position: 0, y_position: 1, game: game, color: 'WHITE')

        king.move_to!(0, 1)
        pawn.reload

        expect(king.x_position).to eq(0)
        expect(king.y_position).to eq(0)

        pawn.reload

        expect(pawn.x_position).to eq(0)
        expect(pawn.y_position).to eq(1)
      end
      it 'king captures a piece of the opposite color' do
        game.pieces.delete_all

        king = King.create(x_position: 0, y_position: 0, game: game, color: 'WHITE', state: 'moved')
        pawn = Pawn.create(x_position: 0, y_position: 1, game: game, color: 'BLACK')

        king.move_to!(0, 1)
        pawn.reload

        expect(king.x_position).to eq(0)
        expect(king.y_position).to eq(1)

        pawn.reload

        expect(pawn.x_position).to eq(nil)
        expect(pawn.y_position).to eq(nil)
      end
    end
  end

  describe 'castle_kingside' do
      let(:game) do
        Game.create(
          white_user: FactoryGirl.create(:user),
          black_user: FactoryGirl.create(:user))
      end

    context 'white king' do
      it 'moves rook to kingside castled position' do
        game.pieces.delete_all
        white_king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        white_rook = Rook.create(x_position: 7, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        game.pieces << white_king
        game.pieces << white_rook

        white_king.valid_move?(6, 0)

        white_king.reload
        white_rook.reload


        expect(white_rook.x_position).to eq(5)
        expect(white_king.x_position).to eq(6)

      end
    end

    context 'white king' do
      it 'moves rook to kingside castled position when king and rook of opposing color are on the board' do
        game.pieces.delete_all
        white_king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        white_rook = Rook.create(x_position: 7, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        black_king = King.create(x_position: 4, y_position: 7, state: 'unmoved', game: game, color: 'BLACK')
        black_rook = Rook.create(x_position: 7, y_position: 7, state: 'unmoved', game: game, color: 'BLACK')

        game.pieces << white_king
        game.pieces << white_rook
        game.pieces << black_king
        game.pieces << black_rook

        white_king.valid_move?(6, 0)

        white_king.reload
        white_rook.reload


        expect(white_rook.x_position).to eq(5)
        expect(white_king.x_position).to eq(6)

      end
    end

    context 'black king' do
      it 'moves rook to kingside castle position' do
        game.pieces.delete_all
        black_king = King.create(x_position: 4, y_position: 7, state: 'unmoved', game: game, color: 'BLACK')
        black_rook = Rook.create(x_position: 7, y_position: 7, state: 'unmoved', game: game, color: 'BLACK')
        game.pieces << black_king
        game.pieces << black_rook

        black_king.valid_move?(6, 0)

        black_king.reload
        black_rook.reload

        expect(black_king.x_position).to eq(6)
        expect(black_rook.x_position).to eq(5)
      end
    end
  end

  describe 'castle_queenside' do
    let(:game) do
      Game.create(
        white_user: FactoryGirl.create(:user),
        black_user: FactoryGirl.create(:user))
    end
    context 'CASTLING' do
      it 'moves rook to queenside castled position' do
        game.pieces.delete_all
        white_king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        white_rook = Rook.create(x_position: 0, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        game.pieces << white_king
        game.pieces << white_rook

        white_king.valid_move?(2, 0)

        white_rook.reload
        white_king.reload

        expect(white_rook.x_position).to eq(3)
        expect(white_king.x_position).to eq(2)
      end

      it 'moves rook to kingside castled position' do
        game.pieces.delete_all
        white_king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        white_rook = Rook.create(x_position: 7, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        game.pieces << white_king
        game.pieces << white_rook

        white_king.valid_move?(6, 0)

        white_rook.reload
        white_king.reload

        expect(white_rook.x_position).to eq(5)
        expect(white_king.x_position).to eq(6)
      end
    end

    context 'white king' do
      it 'moves rook to queenside castled position' do
        game.pieces.delete_all
        white_king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        white_rook = Rook.create(x_position: 0, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
        game.pieces << white_king
        game.pieces << white_rook

        white_king.send(:castle_queenside)
        white_rook.reload
        white_king.reload

        expect(white_rook.x_position).to eq(3)
        expect(white_king.x_position).to eq(2)
      end
    end

    context 'black king' do
      it 'moves rook to queenside castled position' do
        game.pieces.delete_all
        black_king = King.create(x_position: 4, y_position: 7, state: 'unmoved', game: game, color: 'BLACK')
        black_rook = Rook.create(x_position: 0, y_position: 7, state: 'unmoved', game: game, color: 'BLACK')
        game.pieces << black_king
        game.pieces << black_rook

        black_king.send(:castle_queenside)
        black_rook.reload
        black_king.reload

        expect(black_rook.x_position).to eq(3)
        expect(black_king.x_position).to eq(2)
      end
    end
  end

  describe 'no_queenside_obstruction?' do

    it 'returns false when obstructed' do
      game.pieces.delete_all
      white_king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
      white_rook = Rook.create(x_position: 0, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
      white_bishop = Bishop.create(x_position: 2, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
      game.pieces << white_king
      game.pieces << white_rook
      game.pieces << white_bishop

      expect(white_king.send(:no_queenside_obstruction?)).to eq(false)
    end
  end

  describe 'no_kingside_obstruction?' do

    it 'returns false if obstructed' do
      game.pieces.delete_all
      white_king = King.create(x_position: 4, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
      white_rook = Rook.create(x_position: 7, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
      white_bishop = Bishop.create(x_position: 5, y_position: 0, state: 'unmoved', game: game, color: 'WHITE')
      game.pieces << white_king
      game.pieces << white_rook
      game.pieces << white_bishop

      expect(white_king.send(:no_kingside_obstruction?)).to eq(false)
    end
  end

  describe 'legal_castle conditions?' do
    it 'returns false if king has moved' do
      king = game.pieces.where(x_position: 4, y_position: 0, state: 'unmoved', game: game, color: 'WHITE').take
      rook = game.pieces.where(x_position: 7, y_position: 0, state: 'unmoved', game: game, color: 'WHITE').take
      king.update_attributes(state: 'moved')

      expect(king.can_castle_kingside?).to eq(false)
    end

    it 'returns false if rook has moved' do
      king = game.pieces.where(x_position: 4, y_position: 0, state: 'unmoved', game: game, color: 'WHITE').take
      rook = game.pieces.where(x_position: 7, y_position: 0, state: 'unmoved', game: game, color: 'WHITE').take
      rook.update_attributes(state: 'moved')

      expect(king.can_castle_kingside?).to eq(false)
    end
  end
end
