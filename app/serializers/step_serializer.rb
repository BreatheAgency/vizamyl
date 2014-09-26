class StepSerializer < ActiveModel::Serializer
  attributes :id, :position, :title, :page
  has_one :progression

  def progression
    scope.progressions.where(step: object).first
  end

  def page
    { id: object.page.id, type: object.page.type }
  end
end
