class ChapterSerializer < ActiveModel::Serializer
  attributes :id, :title, :position
  has_many :steps
end
