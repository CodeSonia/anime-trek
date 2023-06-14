class RemovePointsFromAchievements < ActiveRecord::Migration[7.0]
  def change
    remove_column :achievements, :points, :integer
  end
end
