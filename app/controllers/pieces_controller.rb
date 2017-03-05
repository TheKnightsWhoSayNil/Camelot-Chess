class PiecesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]

  def show
    @piece = Piece.find_by_id(params[:id])
    @pieces = @piece.game.pieces
  end

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    @color = @piece.color

    x_coordinates = params[:x_position].to_i
    y_coordinates = params[:y_position].to_i
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
