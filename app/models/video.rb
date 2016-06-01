class Video < ActiveRecord::Base
  has_one :step, as: :page, dependent: :destroy
  has_one :chapter, through: :step

  %i(title body subject_area source abbreviations).each do |translated_field|
    translates translated_field
  end

  # FIXME
  # For certain US videos, they would like mandatory videos to be optional
  # Globalize doenst support localised booleans so this is a placeholder
  # til I find a better solution
  US_OPTIONAL_VIDEO_IDS = [2,5,6,7,8,9,10,16,18,22,23,24,25,30,31,32,33,34,35,40,46,50,52,53,54,56,57]
  def mandatory
    if (I18n.locale == :"en-us" && US_OPTIONAL_VIDEO_IDS.include?(self.id))
      false
    else
      read_attribute(:mandatory)
    end
  end

end
