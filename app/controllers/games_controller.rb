class GamesController < ApplicationController

  def show
    @game = [[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    if @game.valid?
      redirect_to game_path(@game)
    else
      render :text, :status => :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:game_id)
  end

end
