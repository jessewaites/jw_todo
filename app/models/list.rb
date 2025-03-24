class List < ApplicationRecord
  belongs_to :user
  has_many :list_items, -> { order(position: :asc) }
end
