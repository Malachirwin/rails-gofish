class User < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :game_users
  has_many :games, through: :game_users
end
