class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || static_path(id: 'course')
  end

  private

  def set_locale
    desired_locale = I18n.default_locale
    # TODO
    return if request.domain == 'herokuapp.com' || 'ngrok.com'
    locale_subdomain = request.subdomain.empty? ? nil : request.subdomain.to_sym
    if user_signed_in?
      desired_locale = current_user.locale.to_sym
      # the current_user has logged in, but is visiting an incorrect localised subdomain.
      # lets point them in the right direction
      if locale_subdomain && desired_locale != locale_subdomain
        redirect_to(request.url.gsub(locale_subdomain.to_s, desired_locale.to_s))
      end
    elsif I18n.available_locales.include?(locale_subdomain)
      desired_locale = locale_subdomain
    elsif params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
      desired_locale = params[:locale].to_sym
    end

    I18n.locale = desired_locale
  end

end
