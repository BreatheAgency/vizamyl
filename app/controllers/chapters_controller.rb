class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.includes(:translations, steps: [:translations, :progression, page: [:progression]]).all
    render json: @chapters
  end

  def show
    @chapter = Chapter.find(params[:id])
    render json: @chapter
  end
end
