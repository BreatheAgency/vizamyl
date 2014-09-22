class ChapterSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :title, :position
  has_many :steps
end
