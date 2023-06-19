class Review < ApplicationRecord
  belongs_to :user
  belongs_to :anime

  validates :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  # validates :user_id, uniqueness: { scope: :anime_id, message: "has already reviewed this anime" }
  # after_create :check_reviews_increase_points

  def check_reviews_increase_points
    if self.user.reviews.size == 1
      self.user.update(points: self.user.points + 10)
      UserAchievement.create!(
        user: self.user,
        achievement: Achievement.find_by(name: "First Review")
      )
    end
    if self.user.reviews.size == 3
      self.user.update(points: self.user.points + 20)
      UserAchievement.create!(
        user: self.user,
        achievement: Achievement.find_by(name: "Review Master")
      )
    end
    if self.user.reviews.size == 50
      self.user.update(points: self.user.points + 50)
      UserAchievement.create!(
        user: self.user,
        achievement: Achievement.find_by(name: "Super Reviewer")
      )
    end
  end
end
