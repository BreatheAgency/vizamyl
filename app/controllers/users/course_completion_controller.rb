class CourseCompletionPDF < Prawn::Document
  def initialize(user)
    super(page_size: 'A4', page_layout: :portrait, left_margin: 0, right_margin: 0, top_margin: 0, bottom_margin: 0)
    font_families.update({
      'geinspira' => {
        normal: Rails.root.join('app/assets/fonts/geinsprg-webfont.ttf'),
        # bold: Rails.root.join('app/assets/fonts/geinspbd-webfont.ttf')
      }
    })
    font('geinspira')
    image(Rails.root.join("app/assets/images/#{I18n.locale}/course-completion-1.jpg"), at: [bounds.absolute_left, PDF::Core::PageGeometry::SIZES['A4'][1] - bounds.absolute_bottom], fit: PDF::Core::PageGeometry::SIZES['A4'])
    left = 243
    top = 408
    height = 32
    margin = 3.5
    fill_color '005cb9'
    text_box("Salutation: " + user.title, at: [left, top + (margin*4) + (height*4)], style: :normal, size: 14)
    text_box("First name: " + user.first_name, at: [left, top + (margin*3) + (height*3)], style: :normal, size: 14)
    text_box("Last name: " + user.last_name, at: [left, top + (margin*2) + (height*2)], style: :normal, size: 14)
    text_box("Date: " + Time.now.strftime("#{Time.now.day.ordinalize} %B %Y"), at: [left, top + margin + height], style: :normal, size: 14)
    start_new_page
    image(Rails.root.join("app/assets/images/#{I18n.locale}/course-completion-2.jpg"), at: [bounds.absolute_left, PDF::Core::PageGeometry::SIZES['A4'][1] - bounds.absolute_bottom], fit: PDF::Core::PageGeometry::SIZES['A4'])
  end
end

class Users::CourseCompletionController < ApplicationController
  before_action :authenticate_user!

  def success
    respond_to do |format|
      format.html
      format.pdf do
        pdf = CourseCompletionPDF.new(current_user)
        send_data pdf.render, filename: 'course_completion.pdf', type: 'application/pdf'
      end
    end
  end

  def failure
  end
end
