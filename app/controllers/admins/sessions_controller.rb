# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  include AuthenticateToken

  # http_basic_authenticate_with name: "admin", password: "$Duke69", only: %i[new]

  before_action :restrict_access, only: %i[new]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
