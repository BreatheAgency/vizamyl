class Question < ActiveRecord::Base
  has_many :answers, -> { order('id ASC') }
  accepts_nested_attributes_for :answers, allow_destroy: true
  has_many :interactive_sources, as: :subject
  accepts_nested_attributes_for :interactive_sources, allow_destroy: true

  %i(title body).each do |translated_field|
    translates translated_field
    active_admin_translates translated_field
  end
end
