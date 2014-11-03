class QuestionSet < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  has_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true

  %i(title).each do |translated_field|
    translates translated_field
    active_admin_translates translated_field
  end
end
