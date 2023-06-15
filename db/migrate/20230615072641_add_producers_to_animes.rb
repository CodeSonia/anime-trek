class AddProducersToAnimes < ActiveRecord::Migration[7.0]
  def change
    add_column :animes, :status, :string
    add_column :animes, :producers, :text, array: true, default: []
    add_column :animes, :themes, :text, array: true, default: []
  end
end
