class PageSerializer < ActiveModel::Serializer
  attributes :id, :type, :title
  # has_one :progression
end
