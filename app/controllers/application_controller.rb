class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :set_locale
  before_action :redirect_locale
  helper_method :needs_black_triangle
  helper_method :users_locale_enrol_path
  helper_method :users_locale_enrol_index_path

  def after_sign_in_path_for(resource)
   if resource.is_a?(AdminUser)
     return "/admin"
   else
     return request.env['omniauth.origin'] || stored_location_for(resource) || "/course/#{I18n.locale}/#{resource.latest_step.page_type.underscore.dasherize.downcase}/#{resource.latest_step.page_id}"
   end
  end

  def after_sign_up_path_for(resource)
    if resource.is_a?(AdminUser)
      return "/admin"
    else
      return "/course/#{I18n.locale}/#{resource.latest_step.page_type.underscore.dasherize.downcase}/#{resource.latest_step.page_id}"
    end
  end

  def set_admin_locale
    I18n.locale = current_admin_user && current_admin_user.locale || I18n.default_locale
  end

  def needs_black_triangle
    return false if I18n.locale == :'en-us'
    request.original_fullpath == users_locale_enrol_index_path || new_user_session_path || users_locale_enrol_path(id: 'details') || users_locale_enrol_path(id: 'marketing') || users_locale_enrol_path(id: 'terms') || users_locale_enrol_path(id: 'institution') || "/#{I18n.locale}"
  end

  def european_locale
    !american_locale
  end

  def american_locale
    I18n.locale == :'en-us'
  end

  def users_locale_enrol_path(*args, &block)
    if european_locale
      return european_enrol_path(*args, &block)
    else
      return american_enrol_path(*args, &block)
    end
  end

  def users_locale_enrol_index_path(*args, &block)
    if european_locale
      return european_enrol_index_path(*args, &block)
    else
      return american_enrol_index_path(*args, &block)
    end
  end

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
