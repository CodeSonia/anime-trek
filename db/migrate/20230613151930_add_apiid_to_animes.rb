class AddApiidToAnimes < ActiveRecord::Migration[7.0]
  def change
    add_column :animes, :api_id, :integer
  end
end
