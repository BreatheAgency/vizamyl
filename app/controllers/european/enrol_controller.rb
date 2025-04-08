class European::EnrolController < ApplicationController
  include Wicked::Wizard
  before_action :reject_admin

  steps *User.form_steps

  def new
    redirect_to users_locale_enrol_path(steps.first)
  end

  def create
    @user = User.new_with_session(filter_params(step).except(:id, :form_step), session)

    if @user.save!
      sign_in_and_redirect
    else
      @user.clean_up_passwords
      render_wizard @user
    end
  end

  def show
    @user = User.new(basic_params(step))
    render_wizard
  end

  def update
    @user = User.new(filter_params(step))

    if user_should_skip_last_step?
      sign_in_and_redirect
    elsif @user.valid?
      redirect_to users_locale_enrol_path(filter_params(step)[:locale], next_step, **filter_params(step).to_h.except(:locale, :id).merge(id: next_step))
    else
      render_wizard @user
    end
  end

  private

  def user_should_skip_last_step?
    italian? && @user.valid? && @user.form_step == "terms" && @user.save!
  end

  def sign_in_and_redirect
    sign_in @user, bypass: true
    redirect_to after_sign_up_path_for(@user)
  end

  def basic_params(step=nil)
    permitted_attributes = [:id, :form_step, :salutation, :first_name, :last_name, :locale, :email, :password, :password_confirmation, :cookies_opt_in, :marketing_overall_opt_in, :marketing_email_opt_in, :marketing_post_opt_in, :marketing_representative_opt_in, :terms_and_conditions_opt_in, :institution, :department, :invite_code, :origin]
    params.permit(permitted_attributes).merge(form_step: step)
  end

  def filter_params(step=nil)
    permitted_attributes = [:id, :form_step, :salutation, :first_name, :last_name, :locale, :email, :password, :password_confirmation, :cookies_opt_in, :marketing_overall_opt_in, :marketing_email_opt_in, :marketing_post_opt_in, :marketing_representative_opt_in, :terms_and_conditions_opt_in, :institution, :department, :invite_code, :origin]
    params.require(:user).permit(permitted_attributes).merge(form_step: step)
  end

end
