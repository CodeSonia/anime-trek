class AddEpisodenumberAndDurationToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :episodenumber, :integer
    add_column :episodes, :duration, :integer
  end
end
