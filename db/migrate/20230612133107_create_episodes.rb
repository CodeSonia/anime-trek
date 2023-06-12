class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :description
      t.string :image
      t.date :date_aired
      t.integer :rating
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
