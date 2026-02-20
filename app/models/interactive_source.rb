class InteractiveSource < ActiveRecord::Base
  belongs_to :subject, polymorphic: true

  %i(label).each do |translated_field|
    translates translated_field
  end
end
