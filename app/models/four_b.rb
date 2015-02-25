class FourB < ActiveRecord::Base
  has_one :step, as: :page, dependent: :destroy
  has_one :chapter, through: :step
  has_many :question_rounds, as: :subject
  accepts_nested_attributes_for :question_rounds, allow_destroy: true

  %i(title subject_area).each do |translated_field|
    translates translated_field
    
  end

end
