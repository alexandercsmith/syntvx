class Tag < ApplicationRecord
  # Modules
  include Approvals
  include Deletions
  include Features
  include Ordering
  include Timing

  # Slug
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associations
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags

  # Attributes
  store_accessor :style

  # Scopes
  scope :active_approved, -> { is_active.is_approved }
  scope :active_unapproved, -> { is_active.is_unapproved }
  scope :active_featured, -> { is_active.is_approved.is_featured }
  scope :include_assoc, -> { includes(:articles) }
  scope :joins_assoc, -> { joins(:articles) }

  # Query
  def self.admin_search(term, filter, page)
    if filter
      case filter
      when "approved"
        active_approved
      when "unapproved"
        active_unapproved
      when "featured"
        active_featured
      else
        is_active
      end
      .include_assoc
      .where('tags.name ilike ?', "%#{term}%")
      .paginate(page: page, per_page: 25)
    else
      all_active
      .paginate(page: page, per_page: 25)
    end
  end

  # Cache
  after_commit :tag_cache_clear
  after_destroy :tag_cache_clear

  def tag_cache_clear
    Rails.cache.delete('Tag.active')
    Rails.cache.delete('Tag.approved')
    Rails.cache.delete('Tag.featured')
    Rails.cache.delete("Tag.#{slug}")
  end

  # Tag.all_active
  def self.all_active
    Rails.cache.fetch('Tag.active', expires_in: 1.hour) do
      is_active.include_assoc.created_desc.to_a
    end
  end

  # Tag.all_inactive - Non-Cache
  def self.all_inactive
    is_inactive.created_desc
  end

  # Tag.all_approved
  def self.all_approved
    Rails.cache.fetch('Tag.approved', expires_in: 1.day) do
      active_approved.include_assoc.name_asc.to_a
    end
  end

  # Tag.all_featured
  def self.all_featured
    Rails.cache.fetch('Tag.featured', expires_in: 1.hour) do
      active_featured.include_assoc.name_asc.to_a
    end
  end

  # Tag.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Tag.#{id}", expires_in: 1.hour) do
      friendly.include_assoc.find(id)
    end
  end
end
