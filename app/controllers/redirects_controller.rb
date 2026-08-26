# app/controllers/redirects_controller.rb
class RedirectsController < ApplicationController

  def country
    origin = params[:origin] || params[:id]

    # 1. Look up this country's configuration (subdomain + locale) from COUNTRY_REDIRECTS
    redirect_config = COUNTRY_REDIRECTS[origin]

    if redirect_config.present?
      # 2. Resolve the locale for this country, falling back to the app default
      #    if no locale was configured for some reason
      locale = redirect_config[:locale].presence || I18n.default_locale

      # 3. Persist the resolved locale in a cookie (not session!) so it survives
      #    Devise's session reset on login and is available on every future request
      cookies[:locale] = { value: locale.to_s, expires: 1.year, httponly: false }

      # 4. Save the country selection to the shared session (kept for anything
      #    else downstream that still relies on session[:origin])
      session[:origin] = origin if origin.present?

      if redirect_config[:subdomain].present?
        # If the country has a designated subdomain (like 'jp' or 'us'),
        # redirect them to that subdomain's clean root homepage (preserving secure protocols)
        protocol = request.ssl? ? 'https' : 'http'
        domain = request.domain
        port = request.port == 80 || request.port == 443 ? "" : ":#{request.port}"

        # Clean, absolute redirect pointing straight to the localized home view,
        # using the country's configured locale rather than the ambient I18n.locale
        redirect_to "#{protocol}://#{redirect_config[:subdomain]}.#{domain}#{port}/#{locale}/home"
      else
        # No subdomain configured for this country (e.g. 'kr') — redirect to the
        # localized home root on the current domain instead
        redirect_to "/#{locale}/home"
      end
    else
      # Fallback: unrecognized country code — redirect to localized home root
      # using whatever locale is currently active
      redirect_to "/#{I18n.locale}/home"
    end
  end

end