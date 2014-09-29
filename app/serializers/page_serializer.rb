class PageSerializer < ActiveModel::Serializer
  attributes :id, :position, :title, :title, :template_name, :controller_name, :chapter_id
  has_one :progression

  def progression
    scope.progressions.where(step: object).first
  end
end
