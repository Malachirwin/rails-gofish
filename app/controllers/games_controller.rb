class GamesController < ApplicationController
  # include SessionsHelper
  skip_before_action :verify_authenticity_token
  before_action :logged_in?

  def show
    @game = Game.find(params[:id])
    @user = current_user
    unless @game.users.include?(@user) || @user == nil
      join_game @game
      pusher_client.trigger("app", "another-joined", {message: 'Another player joined'})
    end
    if @game.users.length == @game.player_num && @game.start_at == nil
      @game.update(start_at: Time.zone.now)
      @game.start
    end
    if @game.go_fish_game != nil && @game.go_fish_game.winners != false
      @game.update(finish_at: Time.zone.now)
      pusher_client.trigger("Game-ended", "Game-is-ended", {message: 'The game is ended'})
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
      pusher_client.trigger("app", "new-games", {message: 'Another Game was added'})
      redirect_to @game
    end
  end

  def new
    @game = Game.new
  end

  def run_round
    @game = Game.find(params[:id])
    player = @game.go_fish_game.players_find_by(name: current_user.name)
    target = @game.go_fish_game.players_find_by(name: params['target_player'])
    result = @game.go_fish_game.run_turn(fisher: player, target: target, rank: params['target_card'])
    @game.save
    pusher_client.trigger('app', "Game/#{@game.id}/show", {message: 'Round has been run'})
  end

  private

  def join_game game
    @game_user = GameUser.create(game_id: game.id, user_id: @user.id)
  end

  def create_game_params
    params.require(:game).permit([:level, :player_num])
  end

end
