# FEATURES
#
# ~/app/models/concerns
#
# $ rails g migration AddFeaturedToModel featured:boolean => default: false
#
# Model: include Features
#
# Model.is_featured     => @models
# Model.is_unfeatured   => @models
#
# @model.featured       => 1 : 0
# @model.feature_toggle => @model.featured | 1 : 0
# @model.feature        => @model.featured | 1
# @model.ordinary       => @model.featured | 0
# @model.featured_check => 'featured' : 'unfeatured'
# @model.featured_link  => 'unfeature' : 'feature'

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
