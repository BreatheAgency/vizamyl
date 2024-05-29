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
    steps_json = ActiveModelSerializers::SerializableResource.new(
      steps,
      each_serializer: StepSerializer,
      scope: current_user  # Pass current_user as scope
    )

    render json: { chapters: chapters_json, steps: steps_json }, root: false
  end


  def show
    @chapter = Chapter.includes(:translations, steps: [page: [:translations]]).find(params[:id])
    render json: {
      chapter: @chapter.attributes.merge(step_ids: @chapter.steps.pluck(:id)),
      steps: ActiveModelSerializers::SerializableResource.new(@chapter.steps, each_serializer: StepSerializer)
    }, root: false
  end

end
