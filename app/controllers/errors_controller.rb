class ErrorsController < ApplicationController
  layout 'gatekeeper'
  skip_before_action :set_locale
  skip_before_action :redirect_locale

  def file_not_found
  end

  def unprocessable
  end

  def internal_server_error
  end

  def upgrade
  end

end
