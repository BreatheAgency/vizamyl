class RobotsController < ApplicationController
  layout nil

  def index
    headers['Content-Type'] = 'text/plain'
    respond_to do |format|
      format.txt
    end
  end
end
