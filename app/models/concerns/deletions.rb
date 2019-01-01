# DELETIONS
#
# ~/app/models/concerns
#
# $ rails g migration AddDeletedToModel deleted:boolean => default: false
#
# Model: include Deletions
#
# Model.is_active       => @models
# Model.is_inactive     => @models
#
# @model.deleted        => 1 : 0
# @model.delete_toggle  => @model.deleted | 1 : 0
# @model.delete         => @model.deleted | 1
# @model.restore        => @model.deleted | 0
# @model.deletion_check => 'deleted' : 'restored'
# @model.deletion_link  => 'restore' : 'delete'

module Deletions
  extend ActiveSupport::Concern
  included do
    scope :is_active, -> { where(deleted: 0) }
    scope :is_inactive, -> { where(deleted: 1) }

    def delete
      update_attribute(:deleted, 1)
    end

    def restore
      update_attribute(:deleted, 0)
    end

    def delete_toggle
      if deleted
        restore
      else
        delete
      end
    end

    def deletion_check
      deleted ? 'deleted' : 'restored'
    end

    def deletion_link
      deleted ? 'restore' : 'delete'
    end
  end
  class_methods do
  end
end
