
class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :join, :destroy]

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to root_path
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
    @black_player = User.find_by(id: @game.black_user_id)
    @white_player = User.find_by(id: @game.white_user_id)
  end

  def new
    @game = Game.new
  end

  def index
    @game = Game.available
  end

  def create
    game = Game.new(game_params)
    game.white_user = current_user
    game.save
    redirect_to game_path(game)
  end

  def join
    @game = Game.find(params[:id])
    if @game.available?
      @game.black_user = current_user
      assign_black_pieces_to_current_user
      @game.save
      redirect_to game_path(@game)
    else
      render :text, :status => :unprocessable_entity
      redirect_to games_path
    end
  end

  private

  def assign_black_pieces_to_current_user
    @game.black_pieces.each do |piece|
      piece.user_id = current_user.id
      piece.save
    end
  end

  def game_params
    params.require(:game).permit(:game_id, :name, :current_user, :black_user_id, :white_user_id)
  end
end
