class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    if account_update_params[:password].blank?
      account_update_params.delete('password')
      account_update_params.delete('password_confirmation')
    end

    #TODO
    account_update_params.delete('password')
    account_update_params.delete('password_confirmation')

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      sign_in @user, bypass: true
      respond_with @user, location: edit_user_registration_path
    else
      clean_up_passwords @user
      respond_with @user
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:salutation, :first_name, :last_name, :locale, :email, :password, :password_confirmation, :marketing_overall_opt_in, :marketing_email_opt_in, :marketing_post_opt_in, :marketing_representative_opt_in, :invite_code)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:salutation, :first_name, :last_name, :password, :password_confirmation, :marketing_overall_opt_in, :marketing_email_opt_in, :marketing_post_opt_in, :marketing_representative_opt_in)
    end
  end

end
