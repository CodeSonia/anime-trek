class CreateAnimes < ActiveRecord::Migration[7.0]
  def change
    create_table :animes do |t|
      t.string :title
      t.string :synopsis
      t.date :date_start
      t.date :date_finish
      t.string :genre
      t.integer :rating
      t.string :image

      t.timestamps
    end
  end
end
