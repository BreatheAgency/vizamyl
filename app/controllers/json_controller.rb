class JsonController < ApplicationController
  skip_before_action :redirect_locale
  before_action :authenticate

  def authenticate
    unless current_user
      render json: nil, status: 401
    end
  end
end
