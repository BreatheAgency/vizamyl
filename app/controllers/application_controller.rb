# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery

  # Bypass our locale and country checks if we are on a Devise auth page.
  # This stops /users/login from getting hijacked and redirecting to the country selector.
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

  # Dynamic URL compilation. This prevents Rails/Devise redirects from jumping 
  # to a static fallback domain in production, matching our active subdomain instead.
  def default_url_options
    { 
      host: request.host, 
      port: request.port, 
      protocol: request.protocol,
      locale: I18n.locale 
    }
  end

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

  def european_locale
    !non_european_locale
  end
  alias_method :european_locale?, :european_locale

  def non_european_locale
    I18n.locale == :'en-us' || I18n.locale == :jp
  end
  alias_method :non_european_locale?, :non_european_locale

  def us_locale?
    I18n.locale == :"en-us"
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

  # Only Japanese want / need to collect this field
  def has_department?
    japanese_locale?
  end

  # Japanese only have one input code in use, and they don't send it out to the users.
  def not_sent_invite_code?
    japanese_locale?
  end

  # Germans need to see a logo which reads "Official G.E. Training Material".
  # This doesn't display for Swiss or Austrian user's who speak German.
  def display_blue_hand_logo?
    return current_user.origin == 'de' if current_user
    return false if via_swiss_gatekeeper? # probably Swiss
    locale == :de
  end

  def users_locale_enrol_path(*args, &block)
    if european_locale
      return european_enrol_path(*args, &block)
    else
      return new_non_european_enrol_path
    end
  end

  def users_locale_enrol_index_path(*args, &block)
    if european_locale
      return european_enrol_index_path(*args, &block)
    else
      return non_european_enrol_index_path(*args, &block)
    end
  end

  private

  # Strict Routing Enforcer: If a request arrives on a subdomain but is missing 
  # the subdomain's native locale in the path (e.g. jp.com/ instead of jp.com/jp),
  # we force a redirect to the fully localized URL instantly.
  def redirect_locale
    # Skip routing checks on asset pipeline calls
    return if request.path.start_with?('/assets')

    # Guard Clause: If the path already has the target locale (e.g. starting with /jp or /jp/),
    # do NOT redirect! This completely prevents /jp/jp redirect loops.
    return if request.path.start_with?("/#{RequestStore.store[:desired_locale]}")

    # Build the correct target path by prepending the desired locale
    target_path = "/#{RequestStore.store[:desired_locale]}#{request.fullpath}"
    redirect_to(target_path) and return
  end

  # Directly maps the request's subdomain to its respective target locale.
  # This matches the subdomains and locales defined in your LoginLink.
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
    when 'uk' then 'en-gb'
    when 'us' then 'en-us'
    when 'ch' then 'ch'
    when 'si' then 'en-us' # SI subdomain shares en-us screens
    else
      I18n.default_locale.to_s
    end
  end

  def set_locale
    # Enforce fallback strictly to the subdomain's native locale
    default_or_subdomain_locale = inferred_subdomain_locale

    RequestStore.store[:desired_locale] = default_or_subdomain_locale
    # Don't fallback locale_in_url so we can detect if it's missing from the path!
    RequestStore.store[:locale_in_url] = request.params.fetch(:locale, nil).to_s

    if user_signed_in?
      RequestStore.store[:desired_locale] = current_user.locale
    elsif I18n.available_locales.include?(RequestStore.store[:locale_in_url].to_sym)
      RequestStore.store[:desired_locale] = RequestStore.store[:locale_in_url]
    end

    if params[:force_locale] && I18n.available_locales.include?(params[:force_locale])
      RequestStore.store[:desired_locale] = params[:force_locale]
    end

    I18n.locale = RequestStore.store[:desired_locale]

    # Automatically overrides and binds all mailer/absolute URL configurations
    # to the exact host domain currently in the user's browser in real-time.
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
    ActionMailer::Base.default_url_options[:protocol] = request.ssl? ? 'https' : 'http'
  end

  def set_origin
    if params[:origin].present?
      session[:origin] = params[:origin]  # Persist origin in session
    end
  end

end