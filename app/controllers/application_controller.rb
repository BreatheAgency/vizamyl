class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_filter :set_locale

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || static_path(id: 'course')
  end

  # private

  # def set_locale
  #   I18n.locale = current_user.locale if current_user
  # end

end
