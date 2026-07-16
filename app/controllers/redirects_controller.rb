# app/controllers/redirects_controller.rb
class RedirectsController < ApplicationController

  def country
    origin = params[:origin] || params[:id]
    
    # Save the country selection to the shared session
    session[:origin] = origin if origin.present?

    # Redirect them to the localized landing page
    redirect_to "/#{I18n.locale}"
  end

end