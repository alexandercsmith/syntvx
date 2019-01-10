# Language
# id
# name        :string :uniq
# slug        :string :uniq
# description :string
# approved    :boolean => false
# featured    :boolean => false
# deleted     :boolean => false
# style       :jsonb => {}
# tools       :association => ToolLanguages
# created_at  :datetime
# updated_at  :datetime

class Language < ApplicationRecord
  # Modules
  include Approvals
  include Deletions
  include Features
  include Ordering
  include Timing

  # Validations
  validates :name,        presence: true, length: { minimum: 1 }
  validates :description, presence: true, length: { minimum: 2 }

  # Slug
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associations
  has_many :tool_languages, dependent: :destroy
  has_many :tools, through: :tool_languages

  # Attributes => :jsonb
  store_accessor :style

  # Scopes
  scope :active_approved, -> { is_active.is_approved }
  scope :active_unapproved, -> { is_active.is_unapproved }
  scope :active_featured, -> { is_active.is_approved.is_featured }
  scope :include_assoc,   -> { includes(:tools) }

  # Query
  def self.admin_search(term, filter, page)
    if filter
      filter_check(filter)
      .include_assoc
      .where('languages.name ilike ?', "%#{term}%")
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
  def self.directory_filter(languages)
    if languages
      friendly.find(languages)
    else
      all_approved
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
    Rails.cache.fetch('Language.active') do
      is_active.include_assoc.created_desc.to_a
    end
  end

  # Language.all_inactive - Non-Cache
  def self.all_inactive
    is_inactive.created_desc
  end

  # Language.all_approved
  def self.all_approved
    Rails.cache.fetch('Language.approved') do
      active_approved.include_assoc.name_asc.to_a
    end
  end

  # Language.all_featured
  def self.all_featured
    Rails.cache.fetch('Language.featured') do
      active_featured.include_assoc.name_asc.to_a
    end
  end

  # Language.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Language.#{id}") do
      friendly.include_assoc.find(id)
    end
  end
end
