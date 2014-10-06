class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.includes(:translations, steps: [:translations, :page]).all
    render json: @chapters
  end

  def show
    @chapter = Chapter.includes(:translations, steps: [:translations, :page]).find(params[:id])
    render json: @chapter
  end
end
