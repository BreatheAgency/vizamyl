class NonEuropean::EnrolController < ApplicationController
  before_action :reject_admin

  def new
    @user = User.new_with_session({}, session)

    if params['origin'] == 'us_native'
      # US Native Healthcare Professionals
      render :new_us_native
    else # Japan, Singapore, Honk Kong, Australia etc
      render :new_other_country
    end
  end

  def create
    @user = User.new_with_session(user_params, session)
    @user.terms_and_conditions_opt_in = true

    if @user.marketing_overall_opt_in
      @user.marketing_email_opt_in = true
      @user.marketing_post_opt_in = true
      @user.marketing_representative_opt_in = true
    end

    if @user.save
      sign_in @user, bypass: true
      redirect_to after_sign_up_path_for(@user)
    else
      @user.clean_up_passwords
      render 'new'
    end
  end

  private

  def user_params
    permitted_attributes = [:salutation, :first_name, :last_name, :locale, :email, :password, :password_confirmation, :cookies_opt_in, :privacy_opt_in, :marketing_overall_opt_in, :marketing_overall_opt_out, :marketing_email_opt_in, :marketing_post_opt_in, :marketing_representative_opt_in, :terms_and_conditions_opt_in, :institution, :department, :invite_code]
    params.require(:user).permit(permitted_attributes)
  end

end
