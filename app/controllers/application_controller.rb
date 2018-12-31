class ApplicationController < ActionController::Base
  include ApplicationHelper

  http_basic_authenticate_with name: "admin", password: "$Duke69"

  def after_sign_in_path_for(resource)
    admins_path
  end
end
