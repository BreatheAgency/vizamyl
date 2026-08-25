# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    locale = params[:locale].presence || I18n.locale
    "/course/#{locale}/text/1"
  end

  def after_sign_out_path_for(resource_or_scope)
    locale = params[:locale].presence || I18n.locale
    "/#{locale}/home"
  end
end