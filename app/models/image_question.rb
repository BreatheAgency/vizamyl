class ImageQuestion < ActiveRecord::Base
  has_one :step, as: :page
  has_one :chapter, through: :step
  has_many :question_sets, as: :subject
  accepts_nested_attributes_for :question_sets, allow_destroy: true
  belongs_to :failure_step, class_name: 'Step'

  %i(title subject_area).each do |translated_field|
    translates translated_field
    active_admin_translates translated_field
  end

end
