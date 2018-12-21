class CreateToolLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :tool_languages do |t|
      t.references :tool, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps
    end
  end
end
