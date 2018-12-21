class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.text :body
      t.boolean :published, default: false
      t.datetime :published_at
      t.boolean :featured, default: false
      t.boolean :deleted, default: false
      t.jsonb :style, default: {}

      t.timestamps
    end
    add_index :articles, :name, unique: true
    add_index :articles, :slug, unique: true
  end
end
