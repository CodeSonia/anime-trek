class AddAnimeToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_reference :episodes, :anime, null: false, foreign_key: true
  end
end
