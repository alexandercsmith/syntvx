module ToolsHelper

  # Tool Cache Clear
  def tool_cache_clear
    Rails.cache.delete('Tool.active')
    Rails.cache.delete('Tool.published')
    Rails.cache.delete('Tool.draft')
    Rails.cache.delete('Tool.featured')
    Rails.cache.delete('Tool.recent')
    Rails.cache.delete("Tool.#{slug}")
  end
  
end
