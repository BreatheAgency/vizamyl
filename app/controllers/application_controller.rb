class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :redirect_locale

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || "/course/#{I18n.locale}/#{resource.latest_step.page_type.underscore.dasherize.downcase}/#{resource.latest_step.page_id}"
  end

  def after_sign_up_path_for(resource)
    "/course/#{I18n.locale}/#{resource.latest_step.page_type.underscore.dasherize.downcase}/#{resource.latest_step.page_id}"
  end

  def set_admin_locale
    I18n.locale = current_admin_user && current_admin_user.locale || I18n.default_locale
  end

  # def active_admin_access_denied(exception)
  #   sign_out(:user)
  #   redirect_to(new_admin_user_session_path, alert: exception.message)
  # end

  private

  def redirect_locale
    if RequestStore.store[:locale_in_url].to_s != RequestStore.store[:desired_locale].to_s && request.fullpath != '/'
      redirect_to(request.fullpath.sub(RequestStore.store[:locale_in_url].to_s, RequestStore.store[:desired_locale].to_s))
    end
  end

  def set_locale
    RequestStore.store[:desired_locale] = I18n.default_locale
    RequestStore.store[:locale_in_url] = request.params.fetch(:locale, I18n.default_locale).to_s

    if user_signed_in?
      RequestStore.store[:desired_locale] = current_user.locale
    elsif I18n.available_locales.include?(RequestStore.store[:locale_in_url].to_sym)
      RequestStore.store[:desired_locale] = RequestStore.store[:locale_in_url]
    end

    if params[:force_locale] && I18n.available_locales.include?(params[:force_locale])
      RequestStore.store[:desired_locale] = params[:force_locale]
    end

    I18n.locale = RequestStore.store[:desired_locale]
  end

end
