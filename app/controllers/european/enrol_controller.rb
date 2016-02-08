class European::EnrolController < ApplicationController
  include Wicked::Wizard
  steps *User.form_steps

  def new
    redirect_to users_locale_enrol_path(steps.first)
  end

  def create
    @user = User.new_with_session(filter_params(step).except(:id, :form_step), session)

    if @user.save!
      sign_in @user, bypass: true
      redirect_to after_sign_up_path_for(@user)
    else
      clean_up_passwords @user
      render_wizard @user
    end
  end

  def show
    @user = User.new(basic_params(step))
    render_wizard
  end

  def update
    @user = User.new(filter_params(step))
    if @user.valid?
      redirect_to users_locale_enrol_path(next_step, filter_params(step).merge(id: next_step))
    else
      render_wizard @user
    end
  end

  private

    def basic_params(step=nil)
      permitted_attributes = [:id, :form_step, :salutation, :first_name, :last_name, :locale, :email, :password, :password_confirmation, :cookies_opt_in, :marketing_overall_opt_in, :marketing_email_opt_in, :marketing_post_opt_in, :marketing_representative_opt_in, :terms_and_conditions_opt_in, :institution, :invite_code]
      params.permit(permitted_attributes).merge(form_step: step)
    end

    def filter_params(step=nil)
      permitted_attributes = [:id, :form_step, :salutation, :first_name, :last_name, :locale, :email, :password, :password_confirmation, :cookies_opt_in, :marketing_overall_opt_in, :marketing_email_opt_in, :marketing_post_opt_in, :marketing_representative_opt_in, :terms_and_conditions_opt_in, :institution, :invite_code]
      params.require(:user).permit(permitted_attributes).merge(form_step: step)
    end
end
