class ImageSource < ActiveRecord::Base
  belongs_to :subject, polymorphic: true

  %i(source).each do |translated_field|
    translates translated_field
  end
end
