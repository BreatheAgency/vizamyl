class Video < ActiveRecord::Base
  has_one :step, as: :page, dependent: :destroy
  has_one :chapter, through: :step

  %i(title body subject_area source abbreviations).each do |translated_field|
    translates translated_field
    
  end

end
