class GamesController < ApplicationController
  include SessionsHelper
  skip_before_action :verify_authenticity_token
  before_action :logged_in?

  def leader_boards
    @game_users = GameUser.all
    @users = User.all
    @results = @users.map do |user|
      leader_board = {wins: 0, ties: 0, losses: 0}
      games = Game.finished.select {|g| g.users.include?(user)}
      games.map do |game|
        game.result(leader_board: leader_board, name: user.name)
      end
      leader_board[:games_played] = games.count
      {name: user.name, leader_board: leader_board}
    end
  end

  def show
    @game = Game.find(params[:id])
    @user = current_user
    unless @game.users.include?(@user) || @user == nil
      join_game @game
      pusher_client.trigger("app", "another-joined", {game_id: @game.id, user_id: "#{@user.id}"})
    end
    if @game.users.length == @game.player_num && @game.start_at == nil
      @game.start
      pusher_client.trigger("app", "game-is-starting", {game_id: @game.id, user_id: "#{@user.id}"})
    end
    if @game.go_fish_game != nil && @game.go_fish_game.winners != false && @game.finish_at == nil
      @game.update(finish_at: Time.zone.now)
      pusher_client.trigger("Game#{@game.id}", "game-has-changed", {message: 'The game is ended'})
    end
    respond_to do |format|
      format.html
      format.json { render json: {game: @game.go_fish_game.players_json(@user.name)} }
    end
  end

  def start_with_bots
    @game = Game.find(params[:id])
    @game.start
    pusher_client.trigger("app", "game-is-starting", {game_id: @game.id, user_id: "#{current_user.id}"})
    redirect_to @game
  end

  def start_now
    @game = Game.find(params[:id])
    if @game.users.length > 1
      @game.update player_num: @game.users.length
      @game.start
      pusher_client.trigger("app", "game-is-starting", {game_id: @game.id, user_id: "#{current_user.id}"})
      redirect_to @game
    else
      redirect_to @game, notice: ["You can't play gofish by your self"]
    end
  end

  def leave
    game = Game.find(params[:id])
    game.game_users.find_by(user: current_user).destroy
    game.destroy if game.users.none?
    pusher_client.trigger("app", "someone-left", {game_id: game.id, user_id: "#{current_user.id}"})
    redirect_to games_path
  end

  def index
    if logged_in?
      @user = current_user
      @in_progress = Game.in_progress.select {|g| g.users.include?(@user)}
      @finished = Game.finished.select {|g| g.users.include?(@user)}
      @pending_games = Game.pending
    else
      redirect_to root_url
    end
  end

  def create
    @game = Game.new(create_game_params)
    if @game.save
      pusher_client.trigger("app", "new-games", {game_id: @game.id, user_id: "#{current_user.id}"})
      redirect_to @game
    end
  end

  def new
    @game = Game.new
  end

  def update_level
    @game = Game.find(params[:id])
    @game.change_level
    pusher_client.trigger("Game#{@game.id}", "game-has-changed", {message: 'Update level'})
  end

  def run_round
    @game = Game.find(params[:id])
    player = @game.go_fish_game.players_find_by(name: current_user.name)
    target = @game.go_fish_game.players_find_by(name: params['target_player'])
    result = @game.go_fish_game.run_turn(fisher: player, target: target, rank: params['target_card'])
    @game.save
    pusher_client.trigger("Game#{@game.id}", "game-has-changed", {message: 'Round has been run'})
  end

  private



  def join_game game
    @game_user = GameUser.create(game_id: game.id, user_id: @user.id)
  end

  def create_game_params
    params.require(:game).permit([:level, :player_num])
  end

end
