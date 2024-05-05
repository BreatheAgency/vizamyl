class PagesController < JsonController
  def show
    clazz = params[:type].singularize.classify.constantize
    @page = clazz.includes(:translations).find(params[:id])
    
    page_json = TextSerializer.new(@page, scope: current_user).as_json
    
    # Access the singular association and wrap it into an array
    step_json = [StepSerializer.new(@page.step, scope: current_user).as_json]
    
    # Remove the "step" key from the page_json
    page_json.delete(:step)
    
    # Create a hash with keys "text" and "steps" (wrapped in an array)
    response_hash = { text: page_json, steps: step_json }
    
    render json: response_hash
  end
end
