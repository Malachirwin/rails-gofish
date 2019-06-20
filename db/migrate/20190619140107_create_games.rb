class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :start_at
      t.datetime :finish_at

      t.timestamps
    end
  end
end
