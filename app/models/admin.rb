# Admin
# id
# email                  :string :uniq
# encrypted_password     :string
# reset_password_token   :string
# reset_password_sent_at :datetime
# remember_created_at    :datetime
# created_at             :datetime
# updated_at             :datetime

class Admin < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  # Attributes => :jsonb
  store_accessor :profile, :name

  # current_admin.get_name
  def get_name
    name.presence ? name.truncate(12) : 'ADMIN'
  end
end
