class PageSerializer < ActiveModel::Serializer
  attributes :id, :position, :title, :title
  has_one :progression

  def progression
    scope.progressions.where(step: object).first
  end
end
