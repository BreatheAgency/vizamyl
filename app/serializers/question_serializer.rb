class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :answers
end
