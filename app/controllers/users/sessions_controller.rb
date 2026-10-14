# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  # TEMPORARY DEBUG: remove once login works.
  prepend_before_action :log_session_state, only: :create

  # ApplicationController behavior.
  def after_sign_out_path_for(resource_or_scope)
    locale = params[:locale].presence || I18n.default_locale
    "/#{locale}/home"
  end

  private

  def log_session_state
    Rails.logger.info(
      "SESSION_DEBUG cookies=#{request.cookies.keys.inspect} " \
      "session_keys=#{session.keys.inspect} " \
      "csrf_in_session=#{session[:_csrf_token].present?}"
    )
  end
end