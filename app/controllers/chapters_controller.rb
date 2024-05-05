class ChaptersController < JsonController
  def index
    @chapters = Chapter.includes(steps: [page: [:translations]]).all
    @steps = Step.where(chapter_id: @chapters.map(&:id)).includes(page: [:translations])

    # Serialize chapters using ChapterSerializer
    chapters_array = ActiveModel::Serializer::CollectionSerializer.new(
      @chapters,
      each_serializer: ChapterSerializer
    ).as_json

    # Serialize steps using StepSerializer
    steps_array = ActiveModel::Serializer::CollectionSerializer.new(
      @steps,
      each_serializer: StepSerializer
    ).as_json

    render json: { chapters: chapters_array, steps: steps_array }
  end

  def show
    @chapter = Chapter.includes(:translations, steps: [page: [:translations]]).find(params[:id])
    render json: @chapter
  end
end
