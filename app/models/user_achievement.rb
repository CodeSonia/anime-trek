class UserAchievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievement

 # after_create :increase_points

 # def increase_points
 #   if self.user.reviews.size == 1
 #     self.user.update(points: self.user.points + 10)
 #   end
 # end
end
