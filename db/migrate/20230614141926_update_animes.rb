class UpdateAnimes < ActiveRecord::Migration[7.0]
  def change
    add_column :animes, :rank, :integer
    add_column :animes, :image_urls, :text, array: true, default: []
    add_column :animes, :embed_url, :string
  end
end
