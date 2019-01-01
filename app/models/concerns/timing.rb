# ORDERING
#
# ~/app/models/concerns
#
# Model: include Timing
#
# @model.created_date => {Month} ##, ####
# @model.updated_date => {Month} ##, ####
# @model.created_time => i.e. 12:00 PM
# @model.updated_time => i.e. 4:00 AM

module Timing
  extend ActiveSupport::Concern
  included do
    def created_date
      created_at.strftime('%B %e, %Y')
    end

    def updated_date
      updated_at.strftime('%B %e, %Y')
    end

    def created_time
      created_at.strftime('%I:%M %p')
    end

    def updated_time
      updated_at.strftime('%I:%M %p')
    end
  end
  class_methods do
  end
end
