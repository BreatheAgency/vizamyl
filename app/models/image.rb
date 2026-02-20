class Image < ActiveRecord::Base
  has_one :step, as: :page, dependent: :destroy
  has_one :chapter, through: :step

  %i(title subject_area source).each do |translated_field|
    translates translated_field
  end

end
