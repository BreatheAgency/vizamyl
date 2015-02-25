class RobotsController < ApplicationController
  layout nil
  skip_before_action :set_locale

  def index
    headers['Content-Type'] = 'text/plain'
    respond_to do |format|
      format.txt
    end
  end
end
