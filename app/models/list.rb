class List < ApplicationRecord
  belongs_to :user
  has_many :list_items, -> { order(position: :asc) }, dependent: :destroy
  alias_method :items, :list_items
  validates_presence_of :name

  # Method to check if all list items are complete
  def all_items_complete?
    return false if list_items.empty?
    list_items.all? { |item| item.completed? }
  end

  # Method to automatically update list completion status
  def update_completion_status!
    update(completed: all_items_complete?)
  end
end
