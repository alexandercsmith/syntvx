module CategoriesHelper

  # Category Cache Clear
  def category_cache_clear
    Rails.cache.delete('Category.active')
    Rails.cache.delete('Category.approved')
    Rails.cache.delete('Category.draft')
    Rails.cache.delete('Category.featured')
    Rails.cache.delete("Category.#{slug}")
  end
  
end
