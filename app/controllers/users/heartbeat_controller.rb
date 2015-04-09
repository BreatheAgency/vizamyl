class Users::Heartbeat < ApplicationController
  before_action :authenticate_user!
  
  def update
    puts "update?"
  end
end
