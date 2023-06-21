class Anime < ApplicationRecord
  extend FriendlyId

  has_many :episodes, dependent: :delete_all
  has_many :reviews, dependent: :delete_all
  has_many :users, through: :reviews, dependent: :destroy
  has_many :watchlists, dependent: :destroy
  has_many :comments, through: :episodes, dependent: :delete_all
  validates :title, presence: true
  validates :synopsis, presence: true
  validates :date_start, presence: true
  validates :date_finish, presence: true
  validates :genre, presence: true
  validates :rating, presence: true
  validates :image, presence: true
  friendly_id :title, use: :slugged
end
