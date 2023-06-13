class AddEpisodecountToAnimes < ActiveRecord::Migration[7.0]
  def change
    add_column :animes, :episodecount, :integer
  end
end
