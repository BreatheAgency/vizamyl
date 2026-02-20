class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def new
    redirect_to root_path
  end

  def create
    redirect_to root_path
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def update_resource(resource, params)
    resource.update_attributes(params)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:salutation, :first_name, :last_name, :password, :password_confirmation])
  end

end
