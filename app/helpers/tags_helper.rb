module TagsHelper

  # Tag Cache Clear
  def tag_cache_clear
    Rails.cache.delete('Tag.active')
    Rails.cache.delete('Tag.approved')
    Rails.cache.delete('Tag.draft')
    Rails.cache.delete('Tag.featured')
    Rails.cache.delete("Tag.#{slug}")
    Rails.cache.delete("Tag.#{id}.articles")
  end
  
end
