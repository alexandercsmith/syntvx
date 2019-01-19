# Tag
# id
# name        :string :uniq
# slug        :string :uniq
# description :string
# approved    :boolean => false
# featured    :boolean => false
# deleted     :boolean => false
# style       :jsonb => {}
# articles    :association => ArticleTags
# created_at  :datetime
# updated_at  :datetime

class Tag < ApplicationRecord
  # Modules
  include Approvals
  include Deletions
  include Features
  include Ordering
  include Slugs
  include Timing
  include Validations

  # Functions
  include TagsHelper

  # Associations
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags

  # Attributes => :jsonb
  store_accessor :style

  # Scopes
  scope :include_assoc, -> { includes(:articles) }
  scope :joins_assoc, -> { joins(:articles) }
  scope :active_approved, -> {
    is_active.is_approved.include_assoc
  }
  scope :active_unapproved, -> {
    is_active.is_unapproved.include_assoc
  }
  scope :active_featured, -> {
    is_active.is_approved.is_featured.include_assoc
  }

  # Query
  def self.admin_search(term, filter, page)
    if filter
      filter_check(filter)
      .include_assoc
      .where('tags.name ilike ?', "%#{term}%")
      .paginate(page: page, per_page: 25)
    else
      all_active
      .paginate(page: page, per_page: 25)
    end
  end

  # Query -> filter_check(filter)
  def self.filter_check(filter)
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
  end

  # Cache
  after_commit :tag_cache_clear
  after_destroy :tag_cache_clear

  # Tag.all_active
  def self.all_active
    Rails.cache.fetch('Tag.active') { is_active.created_desc.to_a }
  end
  # Tag.all_inactive - Non-Cache
  def self.all_inactive
    is_inactive.created_desc
  end
  # Tag.all_approved
  def self.all_approved
    Rails.cache.fetch('Tag.approved') { active_approved.name_asc.to_a }
  end
  # Tag.all_drafts
  def self.all_drafts
    Rails.cache.fetch('Tag.draft') { active_unapproved.name_asc.to_a }
  end
  # Tag.all_featured
  def self.all_featured
    Rails.cache.fetch('Tag.featured') { active_featured.name_asc.to_a }
  end
  # Tag.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Tag.#{id}") { friendly.find(id) }
  end
  # @tag.articles_published
  def articles_published
    Rails.cache.fetch("Tag.#{id}.articles") do
      articles.active_published.order(published_at: :desc).to_a
    end
  end
end
