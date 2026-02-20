class SitemapController < ApplicationController
  layout nil
  skip_before_action :set_locale

  def index
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml
    end
  end
end
