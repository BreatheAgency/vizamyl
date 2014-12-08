class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || "/course/#{I18n.locale}/menu"
  end

  def set_admin_locale
    I18n.locale = current_admin_user && current_admin_user.locale || I18n.default_locale
  end

  private

  def set_locale
    desired_locale = I18n.default_locale
    locale_in_url = request.params.fetch(:locale, I18n.default_locale).to_sym

    if user_signed_in?
      desired_locale = current_user.locale
      # the current_user has logged in, but they are visiting the incorrect locale.
      # lets point them in the right direction
      if desired_locale != locale_in_url
        request.params[:locale] = current_user.locale
        # TODO
        # redirect_to(request.params)
      end
    elsif I18n.available_locales.include?(locale_in_url)
      desired_locale = locale_in_url
    end

    if params[:force_locale] && I18n.available_locales.include?(params[:force_locale])
      desired_locale = params[:force_locale]
    end

    I18n.locale = desired_locale
  end

end
