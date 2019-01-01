# APPROVALS
#
# ~/app/models/concerns
#
# $ rails g migration AddApprovedToModel approved:boolean => default: false
#
# Model: include Approvals
#
# Model.is_approved      => @models
# Model.is_unapproved    => @models
#
# @model.approved        => 1 : 0
# @model.approval_toggle => @model.approved | 1 : 0
# @model.approve         => @model.approved | 1
# @model.unapprove       => @model.approved | 0
# @model.approval_check  => 'approved' : 'unapproved'
# @model.approval_link   => 'unapprove' : 'approve'

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
