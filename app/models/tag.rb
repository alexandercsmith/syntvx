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
  include Timing

  # Validations
  validates :name,        presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 2 }

  # Slug
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associations
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags

  # Attributes => :jsonb
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

  def tag_cache_clear
    Rails.cache.delete('Tag.active')
    Rails.cache.delete('Tag.approved')
    Rails.cache.delete('Tag.draft')
    Rails.cache.delete('Tag.featured')
    Rails.cache.delete("Tag.#{slug}")
    Rails.cache.delete("Tag.#{id}.articles")
  end

  # Tag.all_active
  def self.all_active
    Rails.cache.fetch('Tag.active') do
      is_active.include_assoc.created_desc.to_a
    end
  end

  # Tag.all_inactive - Non-Cache
  def self.all_inactive
    is_inactive.created_desc
  end

  # Tag.all_approved
  def self.all_approved
    Rails.cache.fetch('Tag.approved') do
      active_approved.include_assoc.name_asc.to_a
    end
  end

  # Tag.all_drafts
  def self.all_drafts
    Rails.cache.fetch('Tag.draft') do
      active_unapproved.include_assoc.name_asc.to_a
    end
  end

  # Tag.all_featured
  def self.all_featured
    Rails.cache.fetch('Tag.featured') do
      active_featured.include_assoc.name_asc.to_a
    end
  end

  # Tag.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Tag.#{id}") do
      friendly.include_assoc.find(id)
    end
  end

  # @tag.articles_published
  def articles_published
    Rails.cache.fetch("Tag.#{id}.articles") do
      articles.active_published.order(published_at: :desc).to_a
    end
  end
end
