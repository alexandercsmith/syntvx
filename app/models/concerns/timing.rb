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
