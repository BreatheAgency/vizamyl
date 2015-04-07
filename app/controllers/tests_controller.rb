class TestsController < ApplicationController
  skip_before_action :redirect_locale
  def show
    @test = Test.includes(:translations, question_rounds: [questions: [:translations, interactive_sources: [:translations], image_sources: [:translations], answers: [:translations]]]).find(params[:id])
    render json: @test
  end
end
