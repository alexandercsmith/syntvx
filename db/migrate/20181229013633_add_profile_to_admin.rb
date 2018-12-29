class AddProfileToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :profile, :jsonb, default: {}
  end
end
