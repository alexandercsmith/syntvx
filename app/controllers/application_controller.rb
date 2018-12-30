class ApplicationController < ActionController::Base
  include ApplicationHelper

  def after_sign_in_path_for(resource)
    admins_path
  end
end
