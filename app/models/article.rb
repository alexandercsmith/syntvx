class Article < ApplicationRecord
  # Modules
  include Publishing
  include Deletions
  include Features
  include Ordering
  include Timing

  # Slug
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associations
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  # Attributes
  attr_accessor :style

  # Scopes
  scope :active_published, -> { is_active.is_published }
  scope :active_featured, -> { is_active.is_published.is_featured }
  scope :include_assoc, -> { includes(:tags) }
  scope :joins_assoc, -> { joins(:tags) }

  # Query
  def self.admin_search(term, page)
    if term
      is_active
      .where('articles.name ilike ?', "%#{term}%")
      .paginate(page: page, per_page: 25)
    else
      all_active
      .paginate(page: page, per_page: 25)
    end
  end

  # Cache
  after_commit :article_cache_clear
  after_destroy :article_cache_clear

  def article_cache_clear
    Rails.cache.delete('Article.active')
    Rails.cache.delete('Article.published')
    Rails.cache.delete('Article.featured')
    Rails.cache.delete("Article.#{slug}")
  end

  # Article.all_active
  def self.all_active
    Rails.cache.fetch('Article.active', expires_in: 1.day) do
      is_active.include_assoc.created_desc.to_a
    end
  end

  # Article.all_published
  def self.all_published
    Rails.cache.fetch('Article.published', expires_in: 1.day) do
      active_published.include_assoc.name_asc.to_a
    end
  end

  # Article.all_featured
  def self.all_featured
    Rails.cache.fetch('Article.featured', expires_in: 1.day) do
      active_featured.include_assoc.name_asc.to_a
    end
  end

  # Article.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Article.#{id}", expires_in: 1.day) { friendly.include_assoc.find(id) }
  end
end
