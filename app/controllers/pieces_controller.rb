class PiecesController < ApplicationController

  def show
    #show the board again
    @game = Game.find(params[:game_id])
    @pieces = @game.pieces
  end

  def update
    @piece = Piece.find_by_id(params[:id])    
    if @piece.move_to!(@piece.x_position, @piece.y_position) == false      
      render text: "Invalid move, please try again. ..."
      #to do handle the reponse by drag&drop to revert to the starting position   
    else     
      redirect_to game_path(@piece.game)
    end    
  end  

    
    # @piece.update_attributes(piece_params)
    # if @piece.valid?
     # redirect_to game_path(@piece.game)
    # else
    #  return :show, status: :not_acceptable
     

  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
