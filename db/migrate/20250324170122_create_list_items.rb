class CreateListItems < ActiveRecord::Migration[8.0]
  def change
    create_table :list_items do |t|
      t.string :name
      t.references :list, null: false, foreign_key: true
      t.integer :position
      t.string :status

      t.timestamps
    end
  end
end
