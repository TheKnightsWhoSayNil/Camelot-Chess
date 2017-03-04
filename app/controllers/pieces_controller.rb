class PiecesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]

  def show
    @piece = Piece.find_by_id(params[:id])
    @pieces = @piece.game.pieces
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
