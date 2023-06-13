class Anime < ApplicationRecord
  has_many :episodes, dependent: :delete_all
  has_many :reviews


  validates :title, presence: true
  validates :synopsis, presence: true
  validates :date_start, presence: true
  validates :date_finish, presence: true
  validates :genre, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :image, presence: true
end
