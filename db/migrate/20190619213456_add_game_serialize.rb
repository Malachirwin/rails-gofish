class AddGameSerialize < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :go_fish_game, :jsonb, null: false, default: {}
  end
end
