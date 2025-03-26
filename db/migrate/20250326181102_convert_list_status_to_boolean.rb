class ConvertListStatusToBoolean < ActiveRecord::Migration[8.0]
  def change
    remove_column :lists, :status
    add_column :lists, :completed, :boolean, default: false
  end
end
