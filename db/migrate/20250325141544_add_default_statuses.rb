class AddDefaultStatuses < ActiveRecord::Migration[8.0]
  def change
    change_column :lists, :status, :string, default: 'pending'
    change_column :list_items, :status, :string, default: 'pending'
  end
end
