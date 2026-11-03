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
      scope: current_user
    ).as_json

    render_json(chapters: chapters_json, steps: steps_json)
  end

  def show
    @chapter = Chapter.includes(:translations, steps: [page: [:translations]]).find(params[:id])

    steps_json = ActiveModelSerializers::SerializableResource.new(
      @chapter.steps,
      each_serializer: StepSerializer,
      scope: current_user
    ).as_json

    render_json(
      chapter: @chapter.attributes.merge(step_ids: @chapter.steps.pluck(:id)),
      steps: steps_json
    )
  end

  private

  # Bypasses the serializer gem's render hook, which raises FrozenError on Rails 8.
  def render_json(payload)
    render body: payload.to_json, content_type: "application/json"
  end
end