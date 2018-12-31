class ApplicationController < ActionController::Base
  include ApplicationHelper

  http_basic_authenticate_with name: ENV['HTTP_ADMIN'], password: ENV['HTTP_PASS'] if Rails.env == 'production'

  def after_sign_in_path_for(resource)
    admins_path
  end
end
