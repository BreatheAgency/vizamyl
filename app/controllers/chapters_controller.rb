class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.all
    render json: @chapters
  end

  def show
    @chapter = Chapter.find(params[:id])
    render json: @chapter
  end
end
