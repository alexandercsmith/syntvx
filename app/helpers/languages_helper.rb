module LanguagesHelper

  # Language Cache Clear
  def language_cache_clear
    Rails.cache.delete('Language.active')
    Rails.cache.delete('Language.approved')
    Rails.cache.delete('Language.draft')
    Rails.cache.delete('Language.featured')
    Rails.cache.delete("Language.#{slug}")
  end
  
end
