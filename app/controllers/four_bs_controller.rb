class FourBsController < ApplicationController
  skip_before_action :set_locale
  def show
    @four_b = FourB.includes(:translations, question_rounds: [questions: [:translations, interactive_sources: [:translations], image_sources: [:translations], answers: [:translations]]]).find(params[:id])
    render json: @four_b
  end
end
