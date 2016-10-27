class StaticController < ApplicationController
  include HighVoltage::StaticPage
  layout :layout_for_page
  before_action :force_course_authentication!

  private

  def force_course_authentication!
    authenticate_user! if params[:id] == 'course'
  end

  def layout_for_page
    case params[:id]
    when 'course'
      'course'
    when 'gatekeeper', 'gatekeeper-swiss'
      'gatekeeper'
    else
      'application'
    end
  end

end
