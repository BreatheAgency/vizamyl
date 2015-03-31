class PagesController < ApplicationController
  skip_before_action :redirect_locale
  def show
    clazz = params[:type].singularize.classify.constantize
    @page = clazz.includes(:translations).find(params[:id])
    render json: @page
  end
end
