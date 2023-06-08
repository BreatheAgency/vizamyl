class CourseCompletionLetter < Prawn::Document
  def initialize(user)
    super(page_size: 'LETTER', page_layout: :portrait, left_margin: 0, right_margin: 0, top_margin: 0, bottom_margin: 0)
    font_families.update({
      'geinspira' => {
        normal: Rails.root.join('app/assets/fonts/geinsprg-webfont.ttf'),
        # bold: Rails.root.join('app/assets/fonts/geinspbd-webfont.ttf')
      }
    })
    font('geinspira')
    image(Rails.root.join("app/assets/images/course-completion-#{I18n.locale}.jpg"), at: [bounds.absolute_left, PDF::Core::PageGeometry::SIZES['LETTER'][1] - bounds.absolute_bottom], fit: PDF::Core::PageGeometry::SIZES['LETTER'])
    left = 68
    top = 382
    height = 31.5
    margin = 2
    fill_color '005cb9'
    text_box(I18n.t('course_completion.salutation') + ': ' + user.salutation, at: [left, top + (margin*4) + (height*4)], style: :normal, size: 14) if user.salutation.present?
    text_box(I18n.t('course_completion.first_name') + ': ' + user.first_name, at: [left, top + (margin*3) + (height*3)], style: :normal, size: 14)
    text_box(I18n.t('course_completion.last_name') + ': ' + user.last_name, at: [left, top + (margin*2) + (height*2)], style: :normal, size: 14)
    text_box(I18n.t('course_completion.date') + ': ' + I18n.l(Time.now, locale: user.locale, format: "%m/%d/%Y"), at: [left, top + margin + height], style: :normal, size: 14)
  end
end

class CourseCompletionA4 < Prawn::Document
  def initialize(user)
    super(page_size: 'A4', page_layout: :portrait, left_margin: 0, right_margin: 0, top_margin: 0, bottom_margin: 0)
    font_families.update({
      'geinspira' => {
        normal: Rails.root.join('app/assets/fonts/geinsprg-webfont.ttf'),
        # bold: Rails.root.join('app/assets/fonts/geinspbd-webfont.ttf')
      }
    })
    font('geinspira')
    image(Rails.root.join("app/assets/images/course-completion-#{I18n.locale}.jpg"), at: [bounds.absolute_left, PDF::Core::PageGeometry::SIZES['A4'][1] - bounds.absolute_bottom], fit: PDF::Core::PageGeometry::SIZES['A4'])
    left = 212
    top = 422
    height = 32
    margin = 2.1
    fill_color '005cb9'
    text_box(I18n.t('course_completion.salutation') + ': ' + user.salutation, at: [left, top + (margin*4) + (height*4)], style: :normal, size: 14) if user.salutation.present?
    text_box(I18n.t('course_completion.first_name') + ': ' + user.first_name, at: [left, top + (margin*3) + (height*3)], style: :normal, size: 14)
    text_box(I18n.t('course_completion.last_name') + ': ' + user.last_name, at: [left, top + (margin*2) + (height*2)], style: :normal, size: 14)
    date_format = (user.locale == 'en-us') ? "%m/%d/%Y" : "%d/%m/%Y"
    text_box(I18n.t('course_completion.date') + ': ' + I18n.l(Time.now, locale: user.locale, format: date_format), at: [left, top + margin + height], style: :normal, size: 14)
  end
end

class CourseCompletionA4WithDepartment < Prawn::Document
  def initialize(user)
    super(page_size: 'A4', page_layout: :portrait, left_margin: 0, right_margin: 0, top_margin: 0, bottom_margin: 0)
    font_families.update({
                           'arial-ms' => {
                             normal: Rails.root.join('app/assets/fonts/ArialUnicodeMS.ttf'),
                           }
                         })
    font('arial-ms')
    image(Rails.root.join("app/assets/images/course-completion-#{I18n.locale}.jpg"), at: [bounds.absolute_left, PDF::Core::PageGeometry::SIZES['A4'][1] - bounds.absolute_bottom], fit: PDF::Core::PageGeometry::SIZES['A4'])
    left = 38
    top = 375
    height = 36
    margin = 3.5
    fill_color '3d3d3d'
    text_box(I18n.t('course_completion.institution') + ': ' + user.institution, at: [left, top + (margin*5) + (height*5)], style: :normal, size: 14)
    text_box(I18n.t('course_completion.department') + ': ' + user.department.to_s, at: [left, top + (margin*4) + (height*4)], style: :normal, size: 14)
    text_box(I18n.t('course_completion.last_name') + ': ' + user.last_name, at: [left, top + (margin*3) + (height*3)], style: :normal, size: 14)
    text_box(I18n.t('course_completion.first_name') + ': ' + user.first_name, at: [left, top + (margin*2) + (height*2)], style: :normal, size: 14)
    date_format = (user.locale == 'en-us') ? "%m/%d/%Y" : "%d/%m/%Y"
    text_box(I18n.t('course_completion.date') + ': ' + I18n.l(Time.now, locale: user.locale, format: date_format), at: [left, top + margin + height], style: :normal, size: 14)
  end
end

class Users::CourseCompletionController < ApplicationController
  before_action :authenticate_user!

  def success
    current_user.pass!

    if european_locale?
      pdf = CourseCompletionA4.new(current_user)
    elsif japanese_locale?
      pdf = CourseCompletionA4WithDepartment.new(current_user)
    else
      pdf = CourseCompletionLetter.new(current_user)
    end

    respond_to do |format|
      format.html
      format.pdf do
        send_data pdf.render, filename: 'course_completion.pdf', type: 'application/pdf'
      end
    end
  end

  def adjunctive_use_of_quantification
  end

  def refresher_video
  end
end
