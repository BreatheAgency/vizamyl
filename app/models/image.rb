class Image < ActiveRecord::Base
  has_one :step, as: :page
  has_one :chapter, through: :step
  delegate :progression, to: :step

  %i(title subject_area source).each do |translated_field|
    translates translated_field
    active_admin_translates translated_field
  end

end
