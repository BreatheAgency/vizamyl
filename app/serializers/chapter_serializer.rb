class ChapterSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_title, :position, :hidden
  has_many :steps
end
