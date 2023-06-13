class Achievement < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
