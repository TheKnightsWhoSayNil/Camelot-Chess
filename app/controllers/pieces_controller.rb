class PiecesController < ApplicationController

  def show
    #show the board again
    @game = Game.find(params[:game_id])
    @pieces = @game.pieces
  end

  def update 
    @piece = Piece.find_by_id(params[:id])
    if @piece.move_to!(piece_params[:x_position].to_i, piece_params[:y_position].to_i) == false      
      render text: "Invalid move, please try again."
    else    
      render text: "Valid Move"
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
