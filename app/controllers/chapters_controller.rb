class ChaptersController < JsonController
  def index
    @chapters = Chapter.includes(:translations, steps: [page: [:translations]]).all

    chapters_json = @chapters.map do |chapter|
      {
        id: chapter.id,
        title: chapter.title,
        short_title: chapter.short_title,
        position: chapter.position,
        hidden: chapter.hidden,
        step_ids: chapter.steps.pluck(:id)
      }
    end

    steps = @chapters.flat_map(&:steps).uniq
    steps_json = ActiveModelSerializers::SerializableResource.new(steps, each_serializer: StepSerializer)

    render json: { chapters: chapters_json, steps: steps_json }, root: false
  end

  def show
    chapter = Chapter.find(params[:id])
    render json: { chapter: ChapterSerializer.new(chapter, include: ['steps']).as_json }, root: false
  end
end
