class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users
  scope :pending, -> { where(start_at: nil) }
  scope :in_progress, -> { where.not(start_at: nil).where(finish_at: nil) }

  serialize :go_fish_game, GoFishGame

  def start
    player_names = users.map { |u| u.name }
    go_fish_game = GoFishGame.new(level: level, player_names: player_names, player_num: player_num)
    update(go_fish_game: go_fish_game, start_at: Time.zone.now)

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
end
