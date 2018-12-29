class Admins::DashboardController < Admins::AdminAppController

  # GET /admins
  def index
    private_seo('Dashboard')
  end

  # GET /admins/settings
  def settings
    @api_keys = ApiKey.all
    @api_key = ApiKey.new
    private_seo('Settings')
  end

  # POST /admins/api_key
  def create_api_key
    @api_key = ApiKey.new(name: params[:name])
    if @api_key.save
      redirect_to admins_settings_path, notice: 'API Key created.'
    else
      redirect_to admins_settings_path, notice: 'Error creating API Key.'
    end
  end

  # DELETE /admins/api_key/:id
  def destroy_api_key
    @api_key = ApiKey.find(params[:id])
    @api_key.destroy
    redirect_to admins_settings_path, notice: 'API Key destroyed.'
  end

  # GET /trash
  def trash
    @articles = Article.is_inactive
    @categories = Category.is_inactive
    @langauges = Language.is_inactive
    @tags = Tag.is_inactive
    @tools = Tool.is_inactive
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
      # Tools
      Rails.cache.delete('Tool.active')
      Rails.cache.delete('Tool.published')
      Rails.cache.delete('Tool.featured')
      Rails.cache.delete('Tool.recent')
    end

end
