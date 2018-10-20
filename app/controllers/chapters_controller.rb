class ChaptersController < JsonController
  def index
    @chapters = Chapter.includes(:translations, steps: [page: [:translations]]).all
    render json: @chapters
  end

  def show
    @chapter = Chapter.includes(:translations, steps: [page: [:translations]]).find(params[:id])
    render json: @chapter
  end
end
