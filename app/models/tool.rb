# Tool
# id
# name         :string :uniq
# slug         :string :uniq
# description  :string
# published    :boolean => false
# published_at :datetime => nil
# featured     :boolean => false
# deleted      :boolean => false
# links        :jsonb => { :website, :github }
# style        :jsonb => {}
# languages    :association => ToolLanguages
# categories   :association => ToolCategories
# created_at   :datetime
# updated_at   :datetime

class Tool < ApplicationRecord
  # Modules
  include Publishing
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
  has_many :tool_languages, dependent: :destroy
  has_many :languages, through: :tool_languages

  has_many :tool_categories, dependent: :destroy
  has_many :categories, through: :tool_categories

  # Attributes => :jsonb
  store_accessor :links, :website, :github
  store_accessor :style

  # Scopes
  scope :active_published, -> { is_active.is_published }
  scope :active_unpublished, -> { is_active.is_unpublished }
  scope :active_featured, -> { is_active.is_published.is_featured }
  scope :include_assoc, -> { includes(:languages, :categories) }
  scope :joins_assoc, -> { joins(:languages, :categories) }

  # Query
  def self.admin_search(term, filter, page)
    if filter
      filter_check(filter)
      .include_assoc
      .where('tools.name ilike ?', "%#{term}%")
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

  # Directory
  # Tool.directory_search(Boolean, String, @relation, @relation, Integer)
  def self.directory_search(query, term, languages, categories, page)
    if query
      active_published
      .joins_assoc
      .where('tools.name ilike ?', "%#{term}%")
      .where(tool_languages: { language: languages },
             tool_categories: { category: categories })
      .name_asc
      .paginate(per_page: 20, page: page)
    else
      all_published
      .paginate(per_page: 20, page: page)
    end
  end

  # Cache
  after_commit :tool_cache_clear
  after_destroy :tool_cache_clear

  def tool_cache_clear
    Rails.cache.delete('Tool.active')
    Rails.cache.delete('Tool.published')
    Rails.cache.delete('Tool.draft')
    Rails.cache.delete('Tool.featured')
    Rails.cache.delete('Tool.recent')
    Rails.cache.delete("Tool.#{slug}")
  end

  # Tool.all_active
  def self.all_active
    Rails.cache.fetch('Tool.active') do
      is_active.include_assoc.created_desc.to_a
    end
  end

  # Tool.all_inactive - Non-Cache
  def self.all_inactive
    is_inactive.created_desc
  end

  # Tool.all_published
  def self.all_published
    Rails.cache.fetch('Tool.published') do
      active_published.include_assoc.name_asc.to_a
    end
  end

  # Tool.all_drafts
  def self.all_drafts
    Rails.cache.fetch('Tool.draft') do
      active_unpublished.include_assoc.name_asc.to_a
    end
  end

  # Tool.all_featured
  def self.all_featured
    Rails.cache.fetch('Tool.featured') do
      active_featured.include_assoc.name_asc.to_a
    end
  end

  # Tool.all_recent
  def self.all_recent
    Rails.cache.fetch('Tool.recent') do
      active_published.include_assoc.published_desc.limit(10).to_a
    end
  end

  # Tool.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Tool.#{id}") do
      friendly.include_assoc.find(id)
    end
  end
end
