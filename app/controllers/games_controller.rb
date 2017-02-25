class GamesController < ApplicationController

  def show
    @board = [[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]
  end

end
