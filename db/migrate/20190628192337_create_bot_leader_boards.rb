class CreateBotLeaderBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :bot_leader_boards do |t|
      t.integer :user_id
      t.integer :wins
      t.integer :games_played
      t.integer :matches
      t.integer :losses

      t.timestamps
    end
  end
end
