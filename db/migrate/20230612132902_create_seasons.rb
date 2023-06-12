class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.string :image
      t.string :title
      t.date :date_start
      t.date :date_finish
      t.references :anime, null: false, foreign_key: true

      t.timestamps
    end
  end
end
