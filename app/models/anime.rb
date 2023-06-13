class Anime < ApplicationRecord
  has_many :episodes, dependent: :delete_all
end
