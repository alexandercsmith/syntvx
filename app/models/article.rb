# Article
# id
# name         :string :uniq
# slug         :string :uniq
# description  :string
# body         :text [HTML]
# published    :boolean => false
# published_at :datetime => nil
# featured     :boolean => false
# deleted      :boolean => false
# style        :jsonb => {}
# cover_image  :attachement
# tags         :association => ArticleTags
# created_at   :datetime
# updated_at   :datetime

class Article < ApplicationRecord
  # Modules
  include Publishing
  include Deletions
  include Features
  include Ordering
  include Slugs
  include Timing
  include Validations

  # Functions
  include ArticlesHelper

  # Associations
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  # Attributes => :jsonb
  store_accessor :style

  # Images
  has_one_attached :cover_image

  # Scopes
  scope :include_assoc, -> { includes(:tags) }
  scope :joins_assoc, -> { joins(:tags) }
  scope :active_published, -> {
    is_active.is_published.include_assoc
  }
  scope :active_unpublished, -> {
    is_active.is_unpublished.include_assoc
  }
  scope :active_featured, -> {
    is_active.is_published.is_featured.include_assoc
  }

  # Query
  def self.admin_search(term, filter, page)
    if filter
      filter_check(filter)
      .include_assoc
      .where('articles.name ilike ?', "%#{term}%")
      .paginate(page: page, per_page: 25)
    else
      all_active
      .paginate(page: page, per_page: 25)
    end
  end

  # Query -> Published: filter_check(filter)
  def self.filter_check(filter)
    case filter
    when "published"
      active_published
    when "unpublished"
      active_unpublished
    when "featured"
      active_featured
    else
      is_active
    end
  end

  # Cache
  after_commit :article_cache_clear
  after_destroy :article_cache_clear

  # Article.all_active
  def self.all_active
    Rails.cache.fetch('Article.active') { is_active.created_desc.to_a }
  end
  # Article.all_inactive - Non-Cache
  def self.all_inactive
    is_inactive.created_desc
  end
  # Article.all_published
  def self.all_published
    Rails.cache.fetch('Article.published') { active_published.name_asc.to_a }
  end
  # Article.all_drafts
  def self.all_drafts
    Rails.cache.fetch('Article.draft') { active_unpublished.name_asc.to_a }
  end
  # Article.all_featured
  def self.all_featured
    Rails.cache.fetch('Article.featured') { active_featured.name_asc.to_a }
  end
  # Article.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Article.#{id}") { include_assoc.friendly.find(id) }
  end
end
