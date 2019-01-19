# VALIDATIONS
#
# ~/app/models/concerns
#
# Model: include Validations
#

module Validations
  extend ActiveSupport::Concern
  included do

  # Name
  validates :name,  presence: true,
                    length: { minimum: 1 },
                    uniqueness: true

  # Description
  validates :description, presence: true,
                          length: { minimum: 2 }

  end
  class_methods do
  end
end
