class PiecesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]

  def show
    @piece = Piece.find_by_id(params[:id])
    redirect_to game_piece_path(@piece)
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
