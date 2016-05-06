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
  US_OPTIONAL_VIDEO_IDS = []
  def mandatory
    if (I18n.locale == :"en-us" && US_OPTIONAL_VIDEO_IDS.include?(self.id))
      false
    else
      read_attribute(:mandatory)
    end
  end

end
