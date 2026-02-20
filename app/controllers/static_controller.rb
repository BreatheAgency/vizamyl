class StaticController < ApplicationController
  include HighVoltage::StaticPage
  layout :layout_for_page
  before_action :check_if_swiss
  before_action :force_course_authentication!

  private

  def clear_inferred_nationality
    session['probably_swiss'] = nil
  end

  def check_if_swiss
    if params['probably_swiss'].present?
      session['probably_swiss'] = true
    end
  end

  def force_course_authentication!
    authenticate_user! if params[:id] == 'course'
  end

  def layout_for_page
    case params[:id]
    when 'course'
      'course'
    when /gatekeeper/
      clear_inferred_nationality
      'gatekeeper'
    else
      'application'
    end
  end
end
