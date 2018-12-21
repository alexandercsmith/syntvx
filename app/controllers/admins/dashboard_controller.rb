class Admins::DashboardController < Admins::AdminAppController

  # GET /admins
  def index
    private_seo('Dashboard')
  end

  # GET /admins/settings
  def settings
    private_seo('Settings')
  end

  # GET /trash
  def trash
    @articles = Article.is_inactive
    @categories = Category.is_inactive
    @langauges = Language.is_inactive
    @tags = Tag.is_inactive
  end

  # GET /admins/cache_clear
  def cache_clear
    Rails.cache.clear
    redirect_to admins_settings_path
    flash[:notice] = 'Cache Cleared.'
  end

  # GET /admins/explicit_cache_clear
  def explicit_cache_clear
    exp_cache_clear
    redirect_to admins_settings_path
    flash[:notice] = 'Explicit Cache Cleared.'
  end

  private

    # Explicitly Clear General Cache Queries
    def exp_cache_clear
      # Articles
      Rails.cache.delete('Article.active')
      Rails.cache.delete('Article.published')
      Rails.cache.delete('Article.featured')
      Rails.cache.delete("Article.#{slug}")
      # Categories
      Rails.cache.delete('Category.active')
      Rails.cache.delete('Category.approved')
      Rails.cache.delete('Category.featured')
      # Languages
      Rails.cache.delete('Language.active')
      Rails.cache.delete('Language.approved')
      Rails.cache.delete('Language.featured')
      # Tags
      Rails.cache.delete('Tag.active')
      Rails.cache.delete('Tag.approved')
      Rails.cache.delete('Tag.featured')
    end

end
