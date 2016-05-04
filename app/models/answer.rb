class Answer < ActiveRecord::Base
  belongs_to :question

  %i(body).each do |translated_field|
    translates translated_field
  end
end
