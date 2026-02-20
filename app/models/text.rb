class Text < ActiveRecord::Base
  has_one :step, as: :page, dependent: :destroy
  has_one :chapter, through: :step

  %i(title body abbreviations subject_area).each do |translated_field|
    translates translated_field
  end

end
