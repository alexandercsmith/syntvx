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

  # Attributes
  attr_accessor :style

  # Scopes
  scope :active_approved, -> { is_active.is_approved }
  scope :active_featured, -> { is_active.is_approved.is_featured }

  # Query
  def self.admin_search(term, page)
    if term
      is_active
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
    Rails.cache.fetch('Tag.active', expires_in: 1.day) do
      is_active.created_desc.to_a
    end
  end

  # Tag.all_approved
  def self.all_approved
    Rails.cache.fetch('Tag.approved', expires_in: 1.day) do
      active_approved.name_asc.to_a
    end
  end

  # Tag.all_featured
  def self.all_featured
    Rails.cache.fetch('Tag.featured', expires_in: 1.day) do
      active_featured.name_asc.to_a
    end
  end

  # Tag.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Tag.#{id}", expires_in: 1.day) { friendly.find(id) }
  end
end
