# Category
# id
# name        :string :uniq
# slug        :string :uniq
# description :string
# approved    :boolean => false
# featured    :boolean => false
# deleted     :boolean => false
# style       :jsonb => {}
# tools       :association => ToolCategories
# created_at  :datetime
# updated_at  :datetime

class Category < ApplicationRecord
  # Modules
  include Approvals
  include Deletions
  include Features
  include Ordering
  include Slugs
  include Timing
  include Validations

  # Functions
  include CategoriesHelper

  # Associations
  has_many :tool_categories, dependent: :destroy
  has_many :tools, through: :tool_categories

  # Attributes => :jsonb
  store_accessor :style

  # Scopes
  scope :include_assoc,   -> { includes(:tools) }
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
      .where('categories.name ilike ?', "%#{term}%")
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

  # Directory
  def self.directory_filter(categories)
    if categories
      friendly.find(categories)
    else
      all_approved
    end
  end

  # Cache
  after_commit :category_cache_clear
  after_destroy :category_cache_clear

  # Category.all_active
  def self.all_active
    Rails.cache.fetch('Category.active') { is_active.created_desc.to_a }
  end
  # Category.all_inactive - Non-Cache
  def self.all_inactive
    is_inactive.created_desc
  end
  # Category.all_approved
  def self.all_approved
    Rails.cache.fetch('Category.approved') { active_approved.name_asc.to_a }
  end
  # Category.all_drafts
  def self.all_drafts
    Rails.cache.fetch('Category.draft') { active_unapproved.name_asc.to_a }
  end
  # Category.all_featured
  def self.all_featured
    Rails.cache.fetch('Category.featured') { active_featured.name_asc.to_a }
  end
  # Category.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Category.#{id}") { include_assoc.friendly.find(id) }
  end
end
