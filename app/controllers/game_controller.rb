class GameController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
  end

  def create
    game = Game.create(create_game_params)
    redirect_to game_show_url(id: game.id)
  end

  def show
    @user = User.find(session[:user_id])
    @game = Game.find(params[:id])
    if !@game.users.include?(@user)
      join_game @game
    end
    if @game.users.length == @game.player_num && @game.start_at == nil
      @game.update(start_at: Time.zone.now)
      @game.start
    end
  end

  private
  def join_game game
    @game_user = GameUser.create(game_id: game.id, user_id: @user.id)
  end

  def create_game_params
    params.require(:game).permit([:level, :player_num])
  end
end
