class TestsController < ApplicationController
  def show
    @test = Test.includes(:translations, question_rounds: [questions: [:translations, interactive_sources: [:translations], image_sources: [:translations], answers: [:translations]]]).find(params[:id])
    render json: @test
  end
end
