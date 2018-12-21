class Admins::DashboardController < Admins::AdminAppController
  
  # GET /admins
  def index
    private_seo('Dashboard')
  end

  # GET /admins/settings
  def settings
    private_seo('Settings')
  end

  # GET /admins/cache_clear
  def cache_clear
    Rails.cache.clear
    respond_to do |format|
      format.html do
        redirect_to admins_settings_path, notice: 'Cache Cleared.'
      end
    end
  end

end
