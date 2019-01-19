# SLUGGING
#
# ~/app/models/concerns
#
# Model: include Slugs
#

module Slugs
  extend ActiveSupport::Concern
  included do

  extend FriendlyId
  friendly_id :name, use: :slugged

  end
  class_methods do
  end
end
