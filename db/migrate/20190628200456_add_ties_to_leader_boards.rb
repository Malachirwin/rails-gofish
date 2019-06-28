class AddTiesToLeaderBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :bot_leader_boards, :ties, :integer
    add_column :user_leader_boards, :ties, :integer
  end
end
