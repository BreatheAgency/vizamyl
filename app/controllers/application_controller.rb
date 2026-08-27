# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_locale, unless: :devise_controller?
  before_action :set_origin, unless: :devise_controller?
  before_action :redirect_locale, unless: :devise_controller?

  helper_method :european_locale?
  helper_method :non_european_locale?
  helper_method :us_locale?
  helper_method :display_blue_hand_logo?
  helper_method :italian?
  helper_method :users_locale_enrol_path
  helper_method :users_locale_enrol_index_path
  helper_method :has_department?
  helper_method :not_sent_invite_code?

  def default_url_options
    {
      host: request.host,
      port: request.port,
      protocol: request.protocol,
      locale: I18n.locale
    }
  end

  # This already redirects into the course flow post-login — no need for
  # a separate Users::SessionsController override, that would just conflict.
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      request.env['omniauth.origin'] ||
        stored_location_for(resource) ||
        "/course/#{I18n.locale}/#{resource.latest_step.page_type.underscore.dasherize.downcase}/#{resource.latest_step.page_id}"
    end
  end

  def after_sign_up_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      "/course/#{I18n.locale}/#{resource.latest_step.page_type.underscore.dasherize.downcase}/#{resource.latest_step.page_id}"
    end
  end

  def set_admin_locale
    I18n.locale = current_admin_user && current_admin_user.locale || I18n.default_locale
  end

  def reject_admin
    if current_admin_user
      flash[:error] = 'You must logout of this Admin area before you can sign in as a regular user.'
      redirect_to(admin_root_path)
    end
  end

  def european_locale
    !non_european_locale
  end
  alias_method :european_locale?, :european_locale

  def non_european_locale
    I18n.locale == :'en-us' || I18n.locale == :jp
  end
  alias_method :non_european_locale?, :non_european_locale

  def us_locale?
    I18n.locale == :'en-us'
  end

  def italian?
    I18n.locale == :it && !via_swiss_gatekeeper?
  end

  def via_swiss_gatekeeper?
    @via_swiss_gatekeeper ||= session['probably_swiss']
  end

  def japanese_locale?
    I18n.locale == :jp
  end

  def has_department?
    japanese_locale?
  end

  def not_sent_invite_code?
    japanese_locale?
  end

  def display_blue_hand_logo?
    return current_user.origin == 'de' if current_user
    return false if via_swiss_gatekeeper?

    locale == :de
  end

  def users_locale_enrol_path(*args, &block)
    if european_locale
      european_enrol_path(*args, &block)
    else
      new_non_european_enrol_path
    end
  end

  def users_locale_enrol_index_path(*args, &block)
    if european_locale
      european_enrol_index_path(*args, &block)
    else
      non_european_enrol_index_path(*args, &block)
    end
  end

  private

  # Set origin
  def set_origin
    session[:origin] = params[:origin] if params[:origin].present?
  end

  def redirect_locale
    return if request.path.start_with?('/assets')
    return if request.path.start_with?('/course/')
    return if request.path.start_with?("/#{RequestStore.store[:desired_locale]}")

    target_path = "/#{RequestStore.store[:desired_locale]}#{request.fullpath}"
    redirect_to(target_path) and return
  end

  # ch, uk, and si were previously linked to language settings that were either wrong or did not exist.
  # For example, ch did not have a matching language in layouts.yml, while uk and si were using en-gb and en-us, 
  # which were likely mistakes.
  # 
  # Now, each subdomain is linked to a language that actually has a translation file. This prevents the system from 
  # automatically using the default language, which was causing the wrong footer to appear.
  def inferred_subdomain_locale
    subdomain = request.subdomains.first
    return I18n.default_locale.to_s if subdomain.blank? || subdomain == 'www'

    case subdomain
    when 'jp' then 'jp'
    when 'de' then 'de'
    when 'fr' then 'fr'
    when 'it' then 'it'
    when 'es' then 'es'
    when 'at' then 'de-at'
    when 'uk' then 'en'      # Was 'en-gb', which has no translation file
    when 'us' then 'en-us'
    when 'ch' then 'de'      # Was 'ch', not a real locale — see note above
    when 'si' then 'en'      # Was 'en-us' — Slovenia was forced into US locale (possibly wrong)
    else
      I18n.default_locale.to_s
    end
  end

  def set_locale
    default_or_subdomain_locale = inferred_subdomain_locale

    RequestStore.store[:desired_locale] = default_or_subdomain_locale
    RequestStore.store[:locale_in_url] = request.params.fetch(:locale, nil).to_s

    # The language/locale in the URL now takes priority over the language saved on the user's account.
    if I18n.available_locales.include?(RequestStore.store[:locale_in_url].to_sym)
      RequestStore.store[:desired_locale] = RequestStore.store[:locale_in_url]

      # If the user is logged in and their saved language does not match the language in the URL, 
      # the system automatically updates their saved language.
      if user_signed_in? && current_user.locale != RequestStore.store[:locale_in_url]
        current_user.update_column(:locale, RequestStore.store[:locale_in_url])
      end
    elsif user_signed_in? &&
          current_user.locale.present? &&
          I18n.available_locales.include?(current_user.locale.to_sym)
      RequestStore.store[:desired_locale] = current_user.locale
    end

    if params[:force_locale] && I18n.available_locales.include?(params[:force_locale])
      RequestStore.store[:desired_locale] = params[:force_locale]
    end

    I18n.locale = RequestStore.store[:desired_locale]

    ActionMailer::Base.default_url_options[:host] = request.host_with_port
    ActionMailer::Base.default_url_options[:protocol] = request.ssl? ? 'https' : 'http'
  end
end