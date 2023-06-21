class AddSlugToAnimes < ActiveRecord::Migration[7.0]
  def change
    add_column :animes, :slug, :string
    add_index :animes, :slug, unique: true
  end
end
