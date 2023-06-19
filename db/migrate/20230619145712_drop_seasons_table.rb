class DropSeasonsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :seasons
  end
end
