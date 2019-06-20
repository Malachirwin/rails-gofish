class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users
  scope :pending, -> { where(start_at: nil) }
  scope :in_progress, -> { where.not(finished: nil).where(finished: nil) }

  serialize :go_fish_game, Hash

  def start
    player_names = users.map { |u| u.name }
    go_fish_game = GoFishGame.new(level: level, player_names: player_names)
    update(go_fish_game: go_fish_game.state)
  end

  def pending
    start_at == nil
  end
end
