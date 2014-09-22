class StepsController < ApplicationController
  def show
    @step = Step.find(params[:id]).page
    render json: @step
  end
end
