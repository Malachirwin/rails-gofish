class SessionsController < ApplicationController
  # include SessionsHelper
  skip_before_action :verify_authenticity_token
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by(name: params[:user][:name])
    if @user.save
      log_in @user
      redirect_to games_url(@user)
    else
      redirect_to root_url, notice: @user.errors
    end
  end
end
