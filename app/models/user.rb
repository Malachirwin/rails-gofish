class User < ApplicationRecord
  before_create :git_rid_of_spaces
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 10, minimum: 2}
  has_many :game_users
  has_many :games, through: :game_users

  def git_rid_of_spaces
    self.name = self.name.split(' ').join('')
  end
end
