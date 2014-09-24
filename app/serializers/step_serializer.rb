class StepSerializer < ActiveModel::Serializer
  attributes :id, :position, :title, :page
  has_one :progression

  def page
    { id: object.page.id, type: object.page.type }
  end
end
