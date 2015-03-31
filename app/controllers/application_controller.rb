class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || "/course/#{I18n.locale}/#{resource.latest_step.page_type.dasherize.downcase}/#{resource.latest_step.page_id}"
  end

  def after_sign_up_path_for(resource)
    "/course/#{I18n.locale}/#{resource.latest_step.page_type.dasherize.downcase}/#{resource.latest_step.page_id}"
  end

  def set_admin_locale
    I18n.locale = current_admin_user && current_admin_user.locale || I18n.default_locale
  end

  # def active_admin_access_denied(exception)
  #   sign_out(:user)
  #   redirect_to(new_admin_user_session_path, alert: exception.message)
  # end
  
  private

  def set_locale
    desired_locale = I18n.default_locale
    locale_in_url = request.params.fetch(:locale, I18n.default_locale).to_s

    if user_signed_in?
      desired_locale = current_user.locale
    elsif I18n.available_locales.include?(locale_in_url.to_sym)
      desired_locale = locale_in_url
    end
    
    if locale_in_url.to_s != desired_locale.to_s && request.fullpath != '/'
      redirect_to(request.fullpath.sub(locale_in_url.to_s, desired_locale.to_s))
    end

    if params[:force_locale] && I18n.available_locales.include?(params[:force_locale])
      desired_locale = params[:force_locale]
    end

    I18n.locale = desired_locale
  end

end
