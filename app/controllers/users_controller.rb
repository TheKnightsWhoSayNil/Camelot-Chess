require 'pry'
class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
   @my_games = my_games
   @open_games = open_games
 end

 def my_games
   if user_signed_in?
     @my_games = Game.where('black_user_id = ? or white_user_id = ?', current_user.id, current_user.id)
   end
 end

 def open_games
   if user_signed_in?
     @open_games = Game.where(black_user_id: nil).where.not(white_user_id: current_user.id)
   end
 end
end
