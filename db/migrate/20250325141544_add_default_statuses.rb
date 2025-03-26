class AddDefaultStatuses < ActiveRecord::Migration[8.0]
  def change
    rename_column :list_items, :old_column, :complete
    change_column :list_items, :status, :string, default: 'pending'
  end
end
