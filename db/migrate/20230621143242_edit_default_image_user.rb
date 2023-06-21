require 'faker'
class EditDefaultImageUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :photo, :string, default: Faker::Avatar.image
  end
end
