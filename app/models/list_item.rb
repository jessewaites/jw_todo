class ListItem < ApplicationRecord
  belongs_to :list, dependent: :destroy
  acts_as_list scope: :list
end
