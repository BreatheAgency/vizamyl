class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :set_locale
  before_action :redirect_locale
  helper_method :needs_black_triangle
  helper_method :european_locale?
  helper_method :non_european_locale?
  helper_method :users_locale_enrol_path
  helper_method :users_locale_enrol_index_path
  helper_method :has_department?
  helper_method :was_sent_invite_code?

  def after_sign_in_path_for(resource)
   if resource.is_a?(AdminUser)
     return admin_root_path
   else
     return request.env['omniauth.origin'] || stored_location_for(resource) || "/course/#{I18n.locale}/#{resource.latest_step.page_type.underscore.dasherize.downcase}/#{resource.latest_step.page_id}"
   end
  end

  def after_sign_up_path_for(resource)
    if resource.is_a?(AdminUser)
      return admin_root_path
    else
      return "/course/#{I18n.locale}/#{resource.latest_step.page_type.underscore.dasherize.downcase}/#{resource.latest_step.page_id}"
    end
  end

  def set_admin_locale
    I18n.locale = current_admin_user && current_admin_user.locale || I18n.default_locale
  end

  def reject_admin
    if current_admin_user
      flash[:error] = "You must logout of this Admin area before you can sign in as a regular user."
      redirect_to(admin_root_path)
    end
  end

  def needs_black_triangle
    return false if I18n.locale == :'en-us'
    request.original_fullpath == users_locale_enrol_index_path || new_user_session_path || users_locale_enrol_path(id: 'details') || users_locale_enrol_path(id: 'marketing') || users_locale_enrol_path(id: 'terms') || users_locale_enrol_path(id: 'institution') || "/#{I18n.locale}"
  end

  def european_locale
    !non_european_locale
  end
  alias_method :european_locale?, :european_locale

  def non_european_locale
    I18n.locale == :'en-us' || I18n.locale == :jp
  end
  alias_method :non_european_locale?, :non_european_locale

  def japanese_locale?
    I18n.locale == :jp
  end

  def users_locale_enrol_path(*args, &block)
    if european_locale
      return european_enrol_path(*args, &block)
    else
      return new_non_european_enrol_path
    end
  end

  # Only Japanses want / need to collect this field
  def has_department?
    japanese_locale?
  end

  # Japanese only have one input code in use, and they don't send it out to the users.
  def was_sent_invite_code?
    !japanese_locale?
  end

  def users_locale_enrol_index_path(*args, &block)
    if european_locale
      return european_enrol_index_path(*args, &block)
    else
      return non_european_enrol_index_path(*args, &block)
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
