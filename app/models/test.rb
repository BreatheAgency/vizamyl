class Test < ActiveRecord::Base
  has_one :step, as: :page, dependent: :destroy
  has_one :chapter, through: :step
  has_many :question_rounds, as: :subject
  accepts_nested_attributes_for :question_rounds, allow_destroy: true
  belongs_to :failure_step, class_name: 'Step'

  %i(subject_area results_title results_correct results_incorrect).each do |translated_field|
    translates translated_field
  end

  alias_attribute :title, :subject_area

end
