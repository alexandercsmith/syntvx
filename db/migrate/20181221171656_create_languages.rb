class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.boolean :approved, default: false
      t.boolean :featured, default: false
      t.boolean :deleted, default: false
      t.jsonb :style, default: {}

      t.timestamps
    end
    add_index :languages, :name, unique: true
    add_index :languages, :slug, unique: true
  end
end
