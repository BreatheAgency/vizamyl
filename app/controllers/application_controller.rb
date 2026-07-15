# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_origin
  
  # ActiveAdmin and Devise try to skip this callback on boot. 
  # We MUST keep this defined here, otherwise the app crashes on startup with an ArgumentError.
  before_action :set_locale

  # Dynamically builds absolute links/redirects based on the user's current subdomain
  # instead of falling back to a hardcoded host config.
  def default_url_options
    { 
      host: request.host, 
      port: request.port, 
      protocol: request.protocol,
      locale: I18n.locale 
    }
  end

  private

  # Save the origin parameter ONLY if it's actually in the request.
  # This stops /users/login from wiping out our saved session[:origin] when the parameter is missing.
  def set_origin
    if params[:origin].present?
      session[:origin] = params[:origin]
    end
  end

  # Wrapper method to keep our boot callback happy
  def set_locale
    redirect_locale
  end

  # Handles country/locale path routing redirects without getting stuck in infinite loops
  def redirect_locale
    # Skip assets entirely
    return if request.path.start_with?('/assets')

    desired_locale = params[:locale] || session[:locale] || I18n.default_locale

    # Only redirect if we aren't already on the correct localized path
    unless request.path.start_with?("/#{desired_locale}")
      redirect_to url_for(safe_locale_params(desired_locale)) and return
    end

    I18n.locale = desired_locale
    session[:locale] = desired_locale
  end

  # Normalize parameters safely across older and newer Rails versions
  def safe_locale_params(locale)
    safe_params = params.respond_to?(:to_unsafe_h) ? params.to_unsafe_h : params
    safe_params.merge(locale: locale, only_path: true)
  end
end