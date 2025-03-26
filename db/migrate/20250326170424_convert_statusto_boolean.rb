class ConvertStatustoBoolean < ActiveRecord::Migration[8.0]
  def change
    remove_column :list_items, :status
    add_column :list_items, :completed, :boolean, default: false
  end
end
