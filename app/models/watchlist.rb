class Watchlist < ApplicationRecord
  belongs_to :user
  belongs_to :anime

  validates :user_id, presence: true
  validates :anime_id, presence: true
  validates :status, presence: true


  def self.check_watchlists_increase_points(user)
    u = user
    if u.watchlists.size == 1
      u.points += 10
      u.save!
      UserAchievement.create!(
        user: u,
        achievement: Achievement.find_by(name: "Anime Adventurer")
      )
    elsif u.watchlists.size == 5
      u.points += 20
      u.save!
      UserAchievement.create!(
        user: u,
        achievement: Achievement.find_by(name: "Anime Collector")
      )
    elsif u.watchlists.size == 10
      u.points += 50
      u.save!
      UserAchievement.create!(
        user: u,
        achievement: Achievement.find_by(name: "The Anime Connoisseur")
      )
    end
  end

  def self.check_watchlists_decrease_points(user)
    u = user
    if u.watchlists.size == 0
      u.points -= 10
      u.save!
      UserAchievement.find_by(
        user: u,
        achievement: Achievement.find_by(name: "Anime Adventurer")
      ).destroy
    end
    if u.watchlists.size == 4
      u.points -= 20
      u.save!
      UserAchievement.find_by(
        user: u,
        achievement: Achievement.find_by(name: "Anime Collector")
      ).destroy
    end
    if u.watchlists.size == 9
      u.points -= 50
      u.save!
      UserAchievement.find_by(
        user: u,
        achievement: Achievement.find_by(name: "The Anime Connoisseur")
      ).destroy
    end
  end
end
