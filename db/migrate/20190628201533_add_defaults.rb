class AddDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column :user_leader_boards, :wins, :integer, default: 0
    change_column :user_leader_boards, :ties, :integer, default: 0
    change_column :user_leader_boards, :losses, :integer, default: 0
    change_column :user_leader_boards, :matches, :integer, default: 0
    change_column :user_leader_boards, :games_played, :integer, default: 0
    drop_table :bot_leader_boards
  end
end
