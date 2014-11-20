class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :answers
  has_many :interactive_sources
end
