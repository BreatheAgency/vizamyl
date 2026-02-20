class Interactive < ActiveRecord::Base
  has_one :step, as: :page, dependent: :destroy
  has_one :chapter, through: :step
  has_many :interactive_sources, as: :subject
  accepts_nested_attributes_for :interactive_sources, allow_destroy: true

  %i(title body subject_area).each do |translated_field|
    translates translated_field
  end

end
