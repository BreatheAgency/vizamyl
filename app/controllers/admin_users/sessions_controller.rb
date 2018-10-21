class AdminUsers::SessionsController < ActiveAdmin::Devise::SessionsController
  before_action :ensure_logged_out, except: :destroy

  private

  def ensure_logged_out
    if current_user
      render :logout_user_first
    end
  end
end
