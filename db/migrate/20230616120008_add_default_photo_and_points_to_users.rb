class AddDefaultPhotoAndPointsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :photo, :string, default: "https://robohash.org/robo@robohash.org?gravatar=yes"
    change_column :users, :points, :integer, default: 0
  end
end
