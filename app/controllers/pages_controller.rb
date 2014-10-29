class PagesController < ApplicationController
  def show
    clazz = params[:type].singularize.classify.constantize
    @page = clazz.find(params[:id])
    render json: @page
  end
end
