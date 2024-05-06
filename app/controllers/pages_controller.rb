class PagesController < JsonController
  def show
    resource_type = params[:type].singularize.classify
    clazz = resource_type.constantize
    @page = clazz.includes(:translations).find(params[:id])
    
    resource_serializer = "#{resource_type}Serializer".constantize
    
    resource_json = resource_serializer.new(@page, scope: current_user).as_json
    
    # Access the singular association and wrap it into an array
    step_json = [StepSerializer.new(@page.step, scope: current_user).as_json]
    
    # Remove the association from the resource_json
    resource_json.delete(:step)
    
    # Create a hash with keys based on the resource type and steps (wrapped in an array)
    response_hash = { "#{params[:type].downcase}": resource_json, steps: step_json }
    
    render json: response_hash
  end

end

