class PiecesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]

  def show
    #show the board again
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    
    @piece.update_attributes(piece_params)
    if @piece.valid?
      redirect_to game_path
    else
      return :show, status: :not_acceptable
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
