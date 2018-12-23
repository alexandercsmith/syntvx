class Admins::AdminAppController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
end
