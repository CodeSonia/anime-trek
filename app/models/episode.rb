class Episode < ApplicationRecord
  belongs_to :anime, dependent: :destroy
end
