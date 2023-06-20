class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :episode, dependent: :destroy

  validates :content, presence: true

  def self.check_comments_increase_points(user)
    u = user
    if u.comments.size == 1
      u.points += 10
      u.save!
      UserAchievement.create!(
        user: u,
        achievement: Achievement.find_by(name: "The Commentator")
      )
    elsif u.comments.size == 5
      u.points += 20
      u.save!
      UserAchievement.create!(
        user: u,
        achievement: Achievement.find_by(name: "The Chatterbox")
      )
    elsif u.comments.size == 10
      u.points += 50
      u.save!
      UserAchievement.create!(
        user: u,
        achievement: Achievement.find_by(name: "The Socializer")
      )
    end
  end

  def self.check_comments_decrease_points(user)
    u = user
    if u.comments.size == 0
      u.points -= 10
      u.save!
      UserAchievement.find_by(
        user: u,
        achievement: Achievement.find_by(name: "The Commentator")
      ).destroy
    end
    if u.comments.size == 4
      u.points -= 20
      u.save!
      UserAchievement.find_by(
        user: u,
        achievement: Achievement.find_by(name: "The Chatterbox")
      ).destroy
    end
    if u.comments.size == 9
      u.points -= 50
      u.save!
      UserAchievement.find_by(
        user: u,
        achievement: Achievement.find_by(name: "The Socializer")
      ).destroy
    end
  end
end
