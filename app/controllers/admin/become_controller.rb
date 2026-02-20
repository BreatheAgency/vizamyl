class Admin::BecomeController < ApplicationController
  before_action :authenticate_user!

  def become
    if current_user.super_user?
      sign_in(:user, User.find(params[:id]), { bypass: true })
      redirect_to "/#{I18n.locale}/users/edit"
    else
      redirect_to "/"
    end
  end
end
