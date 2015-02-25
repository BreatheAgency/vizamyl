class ChaptersController < ApplicationController
  skip_before_action :set_locale
  def index
    @chapters = Chapter.includes(:translations, steps: [page: [:translations]]).all
    render json: @chapters
  end

  def show
    @chapter = Chapter.includes(:translations, steps: [page: [:translations]]).find(params[:id])
    render json: @chapter
  end
end
