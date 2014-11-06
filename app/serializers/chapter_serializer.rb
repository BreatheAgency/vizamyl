class ChapterSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_title, :position
  has_many :steps
end
