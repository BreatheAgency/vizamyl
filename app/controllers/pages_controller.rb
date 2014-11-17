class PagesController < ApplicationController
  def show
    clazz = params[:type].singularize.classify.constantize
    @page = clazz.includes(:translations).find(params[:id])
    # @page = clazz.includes(:translations, question_rounds: [questions: [:translations, answers: [:translations]]]).find(params[:id])
    render json: @page
  end
end
