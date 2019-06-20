class AddNumOfPlayersToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :player_num, :integer
  end
end
