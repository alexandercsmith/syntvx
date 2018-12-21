class CreateToolCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :tool_categories do |t|
      t.references :tool, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
