class Season < ApplicationRecord
  # belongs_to :anime
  # has_many :episodes

  validates :anime_id, presence: true
  validates :title, presence: true
  validates :image, presence: true
  validates :date_start, presence: true
  validates :date_finish, presence: true
end
