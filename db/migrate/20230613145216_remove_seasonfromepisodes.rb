class RemoveSeasonfromepisodes < ActiveRecord::Migration[7.0]
  def change
    remove_column :episodes, :season_id
  end
end
