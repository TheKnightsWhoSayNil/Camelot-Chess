# Controller that displays the main static page
class StaticPagesController < ApplicationController
  def index
    @clear_navbar = true
  end
end
