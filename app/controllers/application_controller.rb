# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_origin
  
  # ActiveAdmin and Devise look for this callback on boot to skip it.
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

  # Handles country/locale path routing redirects cleanly
  def redirect_locale
    # Skip assets entirely
    return if request.path.start_with?('/assets')

    desired_locale = params[:locale] || session[:locale] || I18n.default_locale

    # Swap or prepend the locale in the raw path string.
    unless request.path.start_with?("/#{desired_locale}")
      new_path = if params[:locale].present?
                   request.fullpath.sub(%r{\A/[^/]+}, "/#{desired_locale}")
                 else
                   "/#{desired_locale}#{request.fullpath}"
                 end
      
      redirect_to new_path and return
    end

    I18n.locale = desired_locale
    session[:locale] = desired_locale
  end
end