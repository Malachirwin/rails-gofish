class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users
  scope :pending, -> { where(start_at: nil) }
  scope :in_progress, -> { where.not(start_at: nil).where(finish_at: nil) }
  scope :finished, -> { where.not(start_at: nil).where.not(finish_at: nil) }

  serialize :go_fish_game, GoFishGame

  def start
    player_names = ordered_users.map { |u| u.name }
    go_fish_game = GoFishGame.new(level: level, player_names: player_names, player_num: player_num)
    update(go_fish_game: go_fish_game, start_at: Time.zone.now)

  end

  def ordered_users
    users.includes(:game_users).sort_by{|user| user.game_users.detect{|game_user| game_user.game_id == id}.created_at}
  end

  def pending
    start_at == nil
  end

  def in_progress
    start_at != nil && finish_at == nil
  end

  def finished
    start_at != nil && finish_at != nil
  end

  def change_level
    if go_fish_game.level == 'hard'
      go_fish_game.set_level('easy')
    else
      go_fish_game.set_level('hard')
    end
    update(go_fish_game: go_fish_game)
  end

  def update_leader_boards
    go_fish_game.winners.map.with_index do |player, index|
      user = User.find_by(name: player.name)
      if index == 0 && user
        leader = UserLeaderBoard.find_or_initialize_by(user_id: user.id)
        if go_fish_game.winners[1].points == player.points
          leader.update(ties: (leader.ties + 1), games_played: (leader.games_played + 1), matches: (leader.matches + player.points))
        else
          leader.update(wins: (leader.wins + 1), games_played: (leader.games_played + 1), matches: (leader.matches + player.points))
        end
      elsif user
        leader = UserLeaderBoard.find_or_initialize_by(user_id: user.id)
        if go_fish_game.winners[0].points == player.points
          leader.update(ties: (leader.ties + 1), games_played: (leader.games_played + 1), matches: (leader.matches + player.points))
        else
          leader.update(losses: (leader.losses + 1), games_played: (leader.games_played + 1), matches: (leader.matches + player.points))
        end
      end
    end
  end
end
