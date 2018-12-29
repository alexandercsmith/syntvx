module Publishing
  extend ActiveSupport::Concern
  included do
    scope :is_published,   -> { where(published: 1) }
    scope :is_unpublished, -> { where(published: 0) }
    scope :published_asc,  -> { order(published_at: :asc) }
    scope :published_desc, -> { order(published_at: :desc) }

    def publish
      update_attribute(:published, 1)
      update_attribute(:published_at, Time.now)
    end

    def unpublish
      update_attribute(:published, 0)
      update_attribute(:published_at, nil)
    end

    def publish_toggle
      if published
        unpublish
      else
        publish
      end
    end

    def published_check
      published ? 'published' : 'unpublished'
    end

    def published_link
      published ? 'unpublish' : 'publish'
    end

    def published_date
      published ? published_at.strftime('%B %e, %Y') : 'DRAFT'
    end

    def published_time
      published ? published_at.strftime('%I:%M %p') : 'DRAFT'
    end
  end
  class_methods do
  end
end
