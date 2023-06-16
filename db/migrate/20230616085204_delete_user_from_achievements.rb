class DeleteUserFromAchievements < ActiveRecord::Migration[7.0]
  def change
    remove_column :achievements, :user_id
  end
end
