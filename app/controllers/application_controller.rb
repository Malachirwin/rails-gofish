require 'pusher'

class ApplicationController < ActionController::Base
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    current_user.name == "Malachi" && current_user.id == 1
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def pusher_client
    @pusher_client ||= Pusher::Client.new(
      app_id: '812121',
      key: '39f3a6aa23acc09d4631',
      secret: '162eb6ba1d17a5ab7df3',
      cluster: 'us2',
      encrypted: true
    )
  end

  def redirect_home?
    return redirect_to root_url if current_user.nil?
  end
end
