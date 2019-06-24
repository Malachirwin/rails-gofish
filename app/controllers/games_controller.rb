class GamesController < ApplicationController
  # include SessionsHelper
  skip_before_action :verify_authenticity_token
  before_action :logged_in?

  def show
    @game = Game.find(params[:id])
    @user = current_user
    unless @game.users.include?(@user) || @user == nil
      join_game @game
    end
    if @game.users.length == @game.player_num && @game.start_at == nil
      @game.update(start_at: Time.zone.now)
      @game.start
    end
    respond_to do |format|
      format.html
      format.json { render json: {game: @game.go_fish_game.players_json(@user.name)} }
    end
  end

  def leave
    game = Game.find(params[:id])
    game.game_users.find_by(user: current_user).destroy
    game.destroy if game.users.none?
    redirect_to games_path
  end

  def index
    if logged_in?
      @in_progress = Game.in_progress
      @user = current_user
      @pending_games = Game.pending
    else
      redirect_to root_url
    end
  end

  def create
    @game = Game.new(create_game_params)
    if @game.save
      redirect_to @game
    end
  end

  def new
    @game = Game.new
  end

  private

  def join_game game
    @game_user = GameUser.create(game_id: game.id, user_id: @user.id)
  end

  def create_game_params
    params.require(:game).permit([:level, :player_num])
  end

end