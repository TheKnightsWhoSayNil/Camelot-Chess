class PiecesController < ApplicationController

  def show
    #show the board again
    @game = Game.find(params[:game_id])

    # @game = Game.find(params[:id])

    @pieces = @game.pieces
  end

  def update

    @piece = Piece.find_by_id(params[:id])
    
    @piece.update_attributes(piece_params)
    if @piece.valid?
      redirect_to game_path(@piece.game)
    else
      return :show, status: :not_acceptable

    # @piece = Piece.find(params[:id])
    # @game = @piece.game

    # if @piece.update_attributes(piece_params)
     # redirect_to game_path(@game)

    end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
