class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.boolean :approved, default: false
      t.boolean :featured, default: false
      t.boolean :deleted, default: false
      t.jsonb :style, default: {}

      t.timestamps
    end
    add_index :tags, :name, unique: true
    add_index :tags, :slug, unique: true
  end
end
