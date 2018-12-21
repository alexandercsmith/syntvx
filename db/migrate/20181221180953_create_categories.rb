class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.boolean :approved, default: false
      t.boolean :featured, default: false
      t.boolean :deleted, default: false
      t.jsonb :style, default: {}

      t.timestamps
    end
    add_index :categories, :name, unique: true
    add_index :categories, :slug, unique: true
  end
end
