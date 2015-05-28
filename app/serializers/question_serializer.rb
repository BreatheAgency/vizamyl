class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :explanation_source, :incorrect_title, :correct_title, :test_case
  has_many :answers
  has_many :interactive_sources
  has_many :image_sources
end
