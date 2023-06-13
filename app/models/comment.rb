class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :episode

  validates :content, presence: true
end
