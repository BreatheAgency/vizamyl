class Question < ActiveRecord::Base
  belongs_to :question_set

  %i(body).each do |translated_field|
    translates translated_field
    active_admin_translates translated_field
  end
end
