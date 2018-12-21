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
