# app/controllers/redirects_controller.rb
class RedirectsController < ApplicationController

  def country
    origin = params[:origin] || params[:id]
    
    # 1. Save the country selection to the shared session
    session[:origin] = origin if origin.present?

    # 2. Get the target subdomain configuration for this country from COUNTRY_REDIRECTS
    redirect_config = COUNTRY_REDIRECTS[origin]

    if redirect_config.present? && redirect_config[:subdomain].present?
      # If the country has a designated subdomain (like 'jp' or 'us'),
      # redirect them to that subdomain's clean root homepage (preserving secure protocols)
      protocol = request.ssl? ? 'https' : 'http'
      domain = request.domain
      port = request.port == 80 || request.port == 443 ? "" : ":#{request.port}"
      
      # Clean, absolute redirect pointing straight to the localised home view
      redirect_to "#{protocol}://#{redirect_config[:subdomain]}.#{domain}#{port}/#{I18n.locale}/home"
    else
      # Fallback: if there is no subdomain configuration, redirect to localised home root
      redirect_to "/#{I18n.locale}/home"
    end
  end

end