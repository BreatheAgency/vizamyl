class ProgressionsController < JsonController
  def index
    progressions = current_user.progressions.all
    render json: progressions
  end

  def show
    @progression = Progression.find(params[:id])
    render json: @progression
  end

  def create
    step = Step.find(progression_params[:step_id])
    progression = current_user.progressions.where(step: step).first_or_create
    if progression_params[:amount] > progression.amount
      progression.amount = progression_params[:amount]
    end
    progression.save
    render json: progression
  end

  def update
    progression = current_user.progressions.find(params[:id])
    progression.update(progression_params.slice(:amount))
    progression.save
    render json: progression
  end

  private

  def progression_params
    params.require(:progression).permit(:amount, :step_id, :user_id)
  end
end
