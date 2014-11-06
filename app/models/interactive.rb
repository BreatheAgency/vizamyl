class Interactive < ActiveRecord::Base
  has_one :step, as: :page, dependent: :destroy
  has_one :chapter, through: :step

  %i(title body subject_area).each do |translated_field|
    translates translated_field
    active_admin_translates translated_field
  end

  def sources_raw
    self.sources.join(',') unless self.sources.nil?
  end

  def sources_raw=(values)
    self.sources = []
    self.sources = values.split(',')
  end

end
