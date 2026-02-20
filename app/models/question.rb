class Question < ActiveRecord::Base
  belongs_to :question_round

  has_many :answers, -> { order('id ASC') }
  accepts_nested_attributes_for :answers, allow_destroy: true

  has_many :interactive_sources, as: :subject
  accepts_nested_attributes_for :interactive_sources, allow_destroy: true

  has_many :image_sources, as: :subject
  accepts_nested_attributes_for :image_sources, allow_destroy: true

  %i(title body correct_title incorrect_title explanation_source).each do |translated_field|
    translates translated_field
  end
end
