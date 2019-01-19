# VALIDATIONS
#
# ~/app/models/concerns
#
# Model: include Validations
#

module Validations
  extend ActiveSupport::Concern
  included do

  validates :name,        presence: true, length: { minimum: 1 }
  validates :description, presence: true, length: { minimum: 2 }

  end
  class_methods do
  end
end
