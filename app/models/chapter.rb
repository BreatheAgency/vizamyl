class Chapter < ActiveRecord::Base
  has_many :steps, -> { where('locales @> ARRAY[?]', [I18n.locale]).order('position ASC') }
  %i(videos texts images interactives question_intros tests four_bs).each do |page_type|
    has_many page_type, through: :steps, source: :page, source_type: page_type.to_s.classify
  end

  acts_as_list scope: [:id]

  %i(title short_title).each do |translated_field|
    translates translated_field
  end
end
