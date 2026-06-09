# Ensure Prawn is loaded in this file
require 'prawn'

# =========================================================================
# 1. UPDATED TEMPLATES (Used when COUNTRY_REDIRECTS[origin][:redirect] is true)
# =========================================================================

class UpdatedCourseCompletionLetter < Prawn::Document
def initialize(user, from_active_admin = false)
  super(page_size: 'LETTER', page_layout: :portrait, left_margin: 0, right_margin: 0, top_margin: 0, bottom_margin: 0)
  font_families.update({
    'geinspira' => {
      normal: Rails.root.join('app/assets/fonts/geinsprg-webfont.ttf'),
    }
  })
  font('geinspira')
  image(Rails.root.join("app/assets/images/course-completion-#{I18n.locale}-updated.jpg"), at: [bounds.absolute_left, PDF::Core::PageGeometry::SIZES['LETTER'][1] - bounds.absolute_bottom], fit: PDF::Core::PageGeometry::SIZES['LETTER'])
  left = 68
  top = 415
  height = 31.5
  margin = 2
  fill_color '6022A6'
  text_box(I18n.t('course_completion.salutation') + ': ' + user.salutation, at: [left, top + (margin*4) + (height*4)], style: :normal, size: 14) if user.salutation.present?
  text_box(I18n.t('course_completion.first_name') + ': ' + user.first_name, at: [left, top + (margin*3) + (height*3)], style: :normal, size: 14)
  text_box(I18n.t('course_completion.last_name') + ': ' + user.last_name, at: [left, top + (margin*2) + (height*2)], style: :normal, size: 14)
  completion_date = from_active_admin ? user.passed_round_two_at : Time.now
  completion_date ||= Time.now
  text_box(I18n.t('course_completion.date') + ': ' + I18n.l(completion_date, locale: user.locale, format: "%m/%d/%Y"), at: [left, top + margin + height], style: :normal, size: 14)
end
end

class UpdatedCourseCompletionA4 < Prawn::Document
def initialize(user, from_active_admin = false)
  super(page_size: 'A4', page_layout: :portrait, left_margin: 0, right_margin: 0, top_margin: 0, bottom_margin: 0)
  font_families.update({
    'geinspira' => {
      normal: Rails.root.join('app/assets/fonts/geinsprg-webfont.ttf'),
    }
  })
  font('geinspira')
  image(Rails.root.join("app/assets/images/course-completion-#{I18n.locale}-updated.jpg"), at: [bounds.absolute_left, PDF::Core::PageGeometry::SIZES['A4'][1] - bounds.absolute_bottom], fit: PDF::Core::PageGeometry::SIZES['A4'])
  left = 68
  top = %i[it].include?(I18n.locale) ? 415 : 445
  height = 32
  margin = 1.6
  fill_color '6022A6'
  text_box(I18n.t('course_completion.salutation') + ': ' + user.salutation, at: [left, top + (margin*4) + (height*4)], style: :normal, size: 14) if user.salutation.present?
  text_box(I18n.t('course_completion.first_name') + ': ' + user.first_name, at: [left, top + (margin*3) + (height*3)], style: :normal, size: 14)
  text_box(I18n.t('course_completion.last_name') + ': ' + user.last_name, at: [left, top + (margin*2) + (height*2)], style: :normal, size: 14)
  completion_date = from_active_admin ? user.passed_round_two_at : Time.now
  completion_date ||= Time.now
  date_format = (user.locale == 'en-us') ? "%m/%d/%Y" : "%d/%m/%Y"
  text_box(I18n.t('course_completion.date') + ': ' + I18n.l(completion_date, locale: user.locale, format: date_format), at: [left, top + margin + height], style: :normal, size: 14)
end
end

class UpdatedCourseCompletionA4WithDepartment < Prawn::Document
def initialize(user, from_active_admin = false)
  super(page_size: 'A4', page_layout: :portrait, left_margin: 0, right_margin: 0, top_margin: 0, bottom_margin: 0)
  font_families.update({
    'arial-ms' => {
      normal: Rails.root.join('app/assets/fonts/ArialUnicodeMS.ttf'),
    }
  })
  font('arial-ms')
  image(Rails.root.join("app/assets/images/course-completion-#{I18n.locale}-updated.jpg"), at: [bounds.absolute_left, PDF::Core::PageGeometry::SIZES['A4'][1] - bounds.absolute_bottom], fit: PDF::Core::PageGeometry::SIZES['A4'])
  left = 68
  top = 410
  height = 32
  margin = 1.6
  fill_color '6022A6'

  text_box(I18n.t('course_completion.institution') + ': ' + user.institution, at: [left, top + (margin*5) + (height*5)], style: :normal, size: 14)
  text_box(I18n.t('course_completion.department') + ': ' + user.department.to_s, at: [left, top + (margin*4) + (height*4)], style: :normal, size: 14)
  text_box(I18n.t('course_completion.last_name') + ': ' + user.last_name, at: [left, top + (margin*3) + (height*3)], style: :normal, size: 14)
  text_box(I18n.t('course_completion.first_name') + ': ' + user.first_name, at: [left, top + (margin*2) + (height*2)], style: :normal, size: 14)
  completion_date = from_active_admin ? user.passed_round_two_at : Time.now
  completion_date ||= Time.now
  date_format = (user.locale == 'en-us') ? "%m/%d/%Y" : "%d/%m/%Y"
  text_box(I18n.t('course_completion.date') + ': ' + I18n.l(completion_date, locale: user.locale, format: date_format), at: [left, top + margin + height], style: :normal, size: 14)
end
end

# =========================================================================
# 2. LEGACY TEMPLATES (Used when COUNTRY_REDIRECTS[origin][:redirect] is false/nil)
# =========================================================================

class LegacyCourseCompletionLetter < Prawn::Document
def initialize(user, from_active_admin = false)
  super(page_size: 'LETTER', page_layout: :portrait, left_margin: 0, right_margin: 0, top_margin: 0, bottom_margin: 0)
  font_families.update({
    'geinspira' => {
      normal: Rails.root.join('app/assets/fonts/geinsprg-webfont.ttf'),
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
  completion_date = from_active_admin ? user.passed_round_two_at : Time.now
  completion_date ||= Time.now
  text_box(I18n.t('course_completion.date') + ': ' + I18n.l(completion_date, locale: user.locale, format: "%m/%d/%Y"), at: [left, top + margin + height], style: :normal, size: 14)
end
end

class LegacyCourseCompletionA4 < Prawn::Document
def initialize(user, from_active_admin = false)
  super(page_size: 'A4', page_layout: :portrait, left_margin: 0, right_margin: 0, top_margin: 0, bottom_margin: 0)
  font_families.update({
    'geinspira' => {
      normal: Rails.root.join('app/assets/fonts/geinsprg-webfont.ttf'),
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
  completion_date = from_active_admin ? user.passed_round_two_at : Time.now
  completion_date ||= Time.now
  date_format = (user.locale == 'en-us') ? "%m/%d/%Y" : "%d/%m/%Y"
  text_box(I18n.t('course_completion.date') + ': ' + I18n.l(completion_date, locale: user.locale, format: date_format), at: [left, top + margin + height], style: :normal, size: 14)
end
end

class LegacyCourseCompletionA4WithDepartment < Prawn::Document
def initialize(user, from_active_admin = false)
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
  completion_date = from_active_admin ? user.passed_round_two_at : Time.now
  completion_date ||= Time.now
  date_format = (user.locale == 'en-us') ? "%m/%d/%Y" : "%d/%m/%Y"
  text_box(I18n.t('course_completion.date') + ': ' + I18n.l(completion_date, locale: user.locale, format: date_format), at: [left, top + margin + height], style: :normal, size: 14)
end
end

# =========================================================================
# 3. CONTROLLER
# =========================================================================

class Users::CourseCompletionController < ApplicationController
before_action :authenticate_user!, unless: :skip_authentication_for_success

def success
  user = current_user || User.find(params[:user_id])
  user.pass! if current_user

  from_active_admin = params[:from_active_admin] == 'true' if params[:from_active_admin]

  I18n.with_locale(user.locale) do
    if redirect_country?(user)
      # Load the updated design classes
      if is_european?(user)
        @pdf = UpdatedCourseCompletionA4.new(user, from_active_admin)
      elsif is_japanese?(user)
        @pdf = UpdatedCourseCompletionA4WithDepartment.new(user, from_active_admin)
      else
        @pdf = UpdatedCourseCompletionLetter.new(user, from_active_admin)
      end
    else
      # Load the legacy design classes
      if is_european?(user)
        @pdf = LegacyCourseCompletionA4.new(user, from_active_admin)
      elsif is_japanese?(user)
        @pdf = LegacyCourseCompletionA4WithDepartment.new(user, from_active_admin)
      else
        @pdf = LegacyCourseCompletionLetter.new(user, from_active_admin)
      end
    end
  end

  respond_to do |format|
    format.html
    format.pdf do
      send_data @pdf.render, filename: 'course_completion.pdf', type: 'application/pdf'
    end
  end
end

def skip_authentication_for_success
  params[:action] == 'success'
end

private

# Clean locale checks evaluated directly on the user object to avoid scope issues
def is_european?(user)
  return false unless user&.locale
  !['en-us', 'jp'].include?(user.locale.to_s.downcase)
end

def is_japanese?(user)
  return false unless user&.locale
  user.locale.to_s.downcase == 'jp'
end

# Safe configuration lookup check
def redirect_country?(user)
  return false unless user&.origin.present?
  
  # Use Kernel.const_get to safely fallback if COUNTRY_REDIRECTS hasn't finished loading yet
  return false unless Object.const_defined?(:COUNTRY_REDIRECTS)
  
  redirect_config = COUNTRY_REDIRECTS[user.origin.to_s.downcase]
  redirect_config.present? && redirect_config[:redirect] == true
end
end