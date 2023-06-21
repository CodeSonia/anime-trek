class AddImageToAchievement < ActiveRecord::Migration[7.0]
  def change
    add_column :achievements, :image, :string
  end
end
