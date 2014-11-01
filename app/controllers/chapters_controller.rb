class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.includes(:translations, steps: [:page]).all
    # , each_serializer: ChapterSerializer, scope: self
    render json: @chapters
  end

  def show
    @chapter = Chapter.includes(:translations, steps: [:page]).find(params[:id])
    # , scope: self
    render json: @chapter
  end
end
