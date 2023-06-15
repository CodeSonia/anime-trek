class Episode < ApplicationRecord
  belongs_to :anime
  has_many :comments, dependent: :destroy
  # validates :season_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :date_aired, presence: true
  validates :rating, presence: true
end
