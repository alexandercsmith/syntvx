class Language < ApplicationRecord
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
  # scope :include_assoc,   -> { includes(:tools) }

  # Query
  def self.admin_search(term, page)
    if term
      is_active
      .where('name ilike ?', term)
      .paginate(page: page, per_page: 25)
    else
      all_active
      .paginate(page: page, per_page: 25)
    end
  end

  # Cache
  after_commit :language_cache_clear
  after_destroy :language_cache_clear

  def language_cache_clear
    Rails.cache.delete('Language.active')
    Rails.cache.delete('Language.approved')
    Rails.cache.delete('Language.featured')
    Rails.cache.delete("Language.#{slug}")
  end

  # Language.all_active
  def self.all_active
    Rails.cache.fetch('Language.active', expires_in: 1.day) do
      is_active.created_desc.to_a
    end
  end

  # Language.all_approved
  def self.all_approved
    Rails.cache.fetch('Language.approved') do
      active_approved.name_asc.to_a
    end
  end

  # Language.all_featured
  def self.all_featured
    Rails.cache.fetch('Language.featured') do
      active_featured.name_asc.to_a
    end
  end

  # Language.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Language.#{id}") { friendly.find(id) }
  end
end
