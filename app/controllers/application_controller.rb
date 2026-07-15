# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_origin
  before_action :set_locale

  # Dynamic default url options. Ensures absolute links are compiled against
  # whichever subdomain/domain the user is currently interacting with.
  def default_url_options
    { 
      host: request.host, 
      port: request.port, 
      protocol: request.protocol,
      locale: I18n.locale 
    }
  end

  private

  # Set origin ONLY if the parameter is present. This prevents navigating
  # to `/users/login` (where ?origin= is missing) from wiping out your selection!
  def set_origin
    if params[:origin].present?
      session[:origin] = params[:origin]
    end
  end

  # Dynamically redirect or set locale based on the incoming path parameters
  def redirect_locale
    # Skip routing/locale checks on asset pipelines or API requests
    return if request.path.start_with?('/assets')

    desired_locale = params[:locale] || session[:locale] || I18n.default_locale

    # Avoid infinite redirect loops if already on the correct path
    unless request.path.start_with?("/#{desired_locale}")
      redirect_to url_for(safe_locale_params(desired_locale)) and return
    end

    I18n.locale = desired_locale
    session[:locale] = desired_locale
  end

  # Safe parameter filtering for redirect compilation
  def safe_locale_params(locale)
    params.to_unsafe_h.merge(locale: locale, only_path: true)
  end
end