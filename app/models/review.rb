class Review < ApplicationRecord
  belongs_to :user
  belongs_to :anime

  validates :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  # validates :user_id, uniqueness: { scope: :anime_id, message: "has already reviewed this anime" }
  def self.check_reviews_increase_points(user)
    u = user
    if u.reviews.size == 1
      u.points += 10
      u.save!
      UserAchievement.create!(
        user: u,
        achievement: Achievement.find_by(name: "The Review Rookie")
      )
    elsif u.reviews.size == 5
      u.points += 20
      u.save!
      UserAchievement.create!(
        user: u,
        achievement: Achievement.find_by(name: "The Review Guru")
      )
    elsif u.reviews.size == 10
      u.points += 50
      u.save!
      UserAchievement.create!(
        user: u,
        achievement: Achievement.find_by(name: "The Review Maestro")
      )
    end
  end

  def self.check_reviews_decrease_points(user)
    u = user
    if u.reviews.size == 0
      u.points -= 10
      u.save!
      UserAchievement.find_by(
        user: u,
        achievement: Achievement.find_by(name: "The Review Rookie")
      ).destroy
    end
    if u.reviews.size == 4
      u.points -= 20
      u.save!
      UserAchievement.find_by(
        user: u,
        achievement: Achievement.find_by(name: "The Review Guru")
      ).destroy
    end
    if u.reviews.size == 9
      u.points -= 50
      u.save!
      UserAchievement.find_by(
        user: u,
        achievement: Achievement.find_by(name: "The Review Maestro")
      ).destroy
    end
  end
end
