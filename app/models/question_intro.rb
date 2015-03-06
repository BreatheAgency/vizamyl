class QuestionIntro < ActiveRecord::Base
  has_one :step, as: :page
  has_one :chapter, through: :step

  %i(title body subject_area).each do |translated_field|
    translates translated_field
  end

end
