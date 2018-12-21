class CreateTools < ActiveRecord::Migration[5.2]
  def change
    create_table :tools do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.boolean :published, default: false
      t.datetime :published_at
      t.boolean :featured, default: false
      t.boolean :deleted, default: false
      t.jsonb :links, default: {}
      t.jsonb :style, default: {}

      t.timestamps
    end
    add_index :tools, :name, unique: true
    add_index :tools, :slug, unique: true
  end
end
