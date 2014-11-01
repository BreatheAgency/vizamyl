class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.includes(:translations, steps: [:progression, :page]).all
    render json: @chapters
  end

  def show
    @chapter = Chapter.includes(:translations, steps: [:progression, :page]).find(params[:id])
    render json: @chapter
  end
end
