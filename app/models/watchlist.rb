class Watchlist < ApplicationRecord
  belongs_to :user
  belongs_to :anime

  validates :user_id, presence: true
  validates :anime_id, presence: true
  validates :status, presence: true
end
