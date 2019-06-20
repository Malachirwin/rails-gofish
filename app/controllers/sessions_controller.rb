class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :verify_authenticity_token
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by(name: params[:user][:name])
    if @user.save
      log_in @user
      redirect_to sessions_index_url(@user)
    else
      flash[:danger] = 'Invalid email/password combination'
      redirect_to root_url
    end
  end

  def index
    if logged_in?
      @user = current_user
      @pending_games = Game.pending
    else
      redirect_to root_url
    end
  end

  def create_game
    if logged_in?
      @game = Game.new
      @user = current_user
      # create game here
    else
      redirect_to root_url
    end
  end
end
