class QuestionRound < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  has_many :questions, -> { order('id ASC') }
  accepts_nested_attributes_for :questions, allow_destroy: true
end
