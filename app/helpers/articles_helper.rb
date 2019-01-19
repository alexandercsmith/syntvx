module ArticlesHelper

  # Article Cache Clear
  def article_cache_clear
    Rails.cache.delete('Article.active')
    Rails.cache.delete('Article.published')
    Rails.cache.delete('Article.draft')
    Rails.cache.delete('Article.featured')
    Rails.cache.delete("Article.#{slug}")
  end

end
