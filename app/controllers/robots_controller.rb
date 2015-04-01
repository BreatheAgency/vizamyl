class RobotsController < ApplicationController
  layout nil
  skip_before_action :set_locale
  skip_before_action :redirect_locale

  def index
    headers['Content-Type'] = 'text/plain'
    respond_to do |format|
      format.txt
    end
  end
end
