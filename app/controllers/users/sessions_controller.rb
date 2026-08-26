# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController

  # ApplicationController behavior.
  def after_sign_out_path_for(resource_or_scope)
    locale = params[:locale].presence || I18n.default_locale
    "/#{locale}/home"
  end
end