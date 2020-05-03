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

  def result leader_board: {wins: 0, ties: 0, losses: 0}
    result = go_fish_game.winners.map.with_index do |player, index|
      user = User.find_by(name: player.name)
      if user
        if index == 0 && go_fish_game.winners[1].points != player.points
          leader_board[:wins] += 1
        elsif go_fish_game.winners[0].points == player.points
          leader_board[:ties] += 1
        else
          leader_board[:losses] += 1
        end
        leader_board
      else
        ''
      end
    end.flatten
    result.select{|r| r != ''}
  end
end
