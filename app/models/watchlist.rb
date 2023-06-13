class Watchlist < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :anime, dependent: :destroy

  validates :user_id, presence: true
  validates :anime_id, presence: true
  validates :status, presence: true
end
