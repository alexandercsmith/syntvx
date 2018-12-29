module AuthenticateToken
  extend ActiveSupport::Concern

  def restrict_access
    api_key = ApiKey.find_by_token(params[:key])
    unless api_key
      redirect_to root_path
    end
  end

end
