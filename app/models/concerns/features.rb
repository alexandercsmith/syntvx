module Features
  extend ActiveSupport::Concern
  included do
    scope :is_featured, -> { where(featured: 1) }
    scope :is_unfeatured, -> { where(featured: 0) }

    def feature
      update_attribute(:featured, 1)
    end

    def ordinary
      update_attribute(:featured, 0)
    end

    def feature_toggle
      if featured
        ordinary
      else
        feature
      end
    end

    def featured_check
      featured ? 'featured' : 'unfeatured'
    end

    def featured_link
      featured ? 'unfeature' : 'feature'
    end
  end
  class_methods do
  end
end
