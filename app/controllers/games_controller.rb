require 'byebug'
class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]

  def show
    @board = [[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]
  end

  def new
    @game = Game.new
  end

  def index
    @game = Game.available
  end

  def create
    game = Game.create(game_params)
    game.white_user = current_user
    game.save
    redirect_to game_path(game)
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    if Game.available
      @game.black_user_id = current_user
      redirect_to game_path(@game)
    else
      render :text, :status => :unprocessable_entity
      redirect_to games_path
    end
  end

  private

  def game_params
    params.require(:game).permit(:game_id, :current_user)
  end
end
