class AddLevelToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :level, :string
  end
end
