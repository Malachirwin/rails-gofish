class GameController < ApplicationController
  skip_before_action :verify_authenticity_token  
  def new
  end

  def create
    binding.pry
    redirect_to game_new_url
  end
end
