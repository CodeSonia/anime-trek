class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :user_profile, dependent: :destroy_async
  has_many :reviews, dependent: :destroy_async
  has_many :watchlists, dependent: :destroy_async
  has_many :comments, dependent: :delete_all
  has_many :user_achievements, dependent: :delete_all
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :username, uniqueness: { case_sensitive: false }
end
