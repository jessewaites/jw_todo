class ListItem < ApplicationRecord
  belongs_to :list, dependent: :destroy
  acts_as_list scope: :list
  validates_presence_of :name


  after_save :check_list_completion

  private

  def check_list_completion
    list.update_completion_status!
  end
end
