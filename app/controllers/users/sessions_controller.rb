class Users::SessionsController < Devise::SessionsController
  before_action :reject_admin, except: :destroy
end
