class Admins::AdminAppController < ApplicationController
  before_action :redirect_admin
  layout 'admin'

  private

    def redirect_admin
      unless current_admin
        redirect_to root_path
      end
    end
end
