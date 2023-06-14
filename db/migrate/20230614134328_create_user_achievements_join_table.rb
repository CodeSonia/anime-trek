class CreateUserAchievementsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :user_achievements do |t|
      t.references :user, foreign_key: true, null: false
      t.references :achievement, foreign_key: true, null: false
      t.timestamps
    end
  end
end
