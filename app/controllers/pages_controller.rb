class PagesController < JsonController
  def show
    resource_type = params[:type].singularize.classify
    clazz = resource_type.constantize
    @page = clazz.includes(:translations).find(params[:id])
    
    resource_serializer = "#{resource_type}Serializer".constantize
    
    resource_json = resource_serializer.new(@page, scope: current_user).as_json
    
    # Access the singular association and wrap it into an array if it's present
    step_json = @page.step ? [StepSerializer.new(@page.step, scope: current_user).as_json] : []
    
    # Remove the association from the resource_json
    resource_json.delete(:step)
    
    # Create a hash with keys based on the resource type and steps (wrapped in an array)
    response_hash = { "#{params[:type].downcase.singularize}": resource_json }
    
    # Move associations outside of the object
    @page.class.reflect_on_all_associations.each do |association|
      association_data = resource_json.delete(association.name)
      response_hash[association.name] = association_data if association_data
    end
    
    # Add steps if present
    response_hash[:steps] = step_json if step_json.any?
    
    render json: response_hash
  end
end
