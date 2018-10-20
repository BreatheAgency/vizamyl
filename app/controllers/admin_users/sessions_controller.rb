class AdminUsers::SessionsController < ActiveAdmin::Devise::SessionsController
  def new
    if current_user
      render :logout_user_first
    else
      super
    end
  end
end
