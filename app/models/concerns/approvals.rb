module Approvals
  extend ActiveSupport::Concern
  included do
    scope :is_approved, -> { where(approved: 1) }
    scope :is_unapproved, -> { where(approved: 0) }

    def approve
      update_attribute(:approved, 1)
    end

    def unapprove
      update_attribute(:approved, 0)
    end

    def approval_toggle
      if approved
        unapprove
      else
        approve
      end
    end

    def approval_check
      approved ? 'approved' : 'unapproved'
    end

    def approval_link
      approved ? 'unapprove' : 'approve'
    end
  end
  class_methods do
  end
end
