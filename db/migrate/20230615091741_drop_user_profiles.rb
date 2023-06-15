class DropUserProfiles < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_profiles
    remove_column :users, :username, :string

    add_column :users, :photo, :string
    add_column :users, :bio, :string
    add_column :users, :points, :integer
  end
end
