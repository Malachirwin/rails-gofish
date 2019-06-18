class SessionController < ApplicationController
  include SessionHelper
  skip_before_action :verify_authenticity_token
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by(name: params[:user][:name])
    if @user.save
      log_in @user
      redirect_to session_game_url(@user)
    else
      flash[:danger] = 'Invalid email/password combination'
      redirect_to root_url
    end
  end

  def game
    if logged_in?
      @user = current_user
    else
      redirect_to root_url
    end
  end

  def create_game
    if logged_in?
      @user = current_user
    else
      redirect_to root_url
    end
  end
end
