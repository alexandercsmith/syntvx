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
  include Timing

  # Validations
  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 2 }

  # Slug
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associations
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  # Attributes => :jsonb
  store_accessor :style

  # Images
  has_one_attached :cover_image

  # Scopes
  scope :active_published, -> { is_active.is_published }
  scope :active_unpublished, -> { is_active.is_unpublished }
  scope :active_featured, -> { is_active.is_published.is_featured }
  scope :include_assoc, -> { includes(:tags) }
  scope :joins_assoc, -> { joins(:tags) }

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

  def article_cache_clear
    Rails.cache.delete('Article.active')
    Rails.cache.delete('Article.published')
    Rails.cache.delete('Article.featured')
    Rails.cache.delete("Article.#{slug}")
  end

  # Article.all_active
  def self.all_active
    Rails.cache.fetch('Article.active') do
      is_active.include_assoc.created_desc.to_a
    end
  end

  # Article.all_inactive - Non-Cache
  def self.all_inactive
    is_inactive.created_desc
  end

  # Article.all_published
  def self.all_published
    Rails.cache.fetch('Article.published') do
      active_published.include_assoc.name_asc.to_a
    end
  end

  # Article.all_featured
  def self.all_featured
    Rails.cache.fetch('Article.featured') do
      active_featured.include_assoc.name_asc.to_a
    end
  end

  # Article.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Article.#{id}") do
      friendly.include_assoc.find(id)
    end
  end
end
