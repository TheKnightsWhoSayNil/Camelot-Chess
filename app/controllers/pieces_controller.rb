class PiecesController < ApplicationController
  
  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game

    if @piece.update_attributes(piece_params)
      redirect_to game_path(@game)
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
