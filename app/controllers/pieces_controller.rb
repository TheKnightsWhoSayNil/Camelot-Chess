class PiecesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]

  def show
    #show the board again
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    @game = @piece.game

    # x = params[:x_position].to_i
    # y = params[:y_position].to_i

    if @piece.update_attributes(piece_params)
      redirect_to game_path(@game)
    end
    
  end
    

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
