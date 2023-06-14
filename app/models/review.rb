class Review < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :anime, dependent: :destroy

  validates :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true,
                                                     }
  # validates :user_id, uniqueness: { scope: :anime_id, message: "has already reviewed this anime" }
end
