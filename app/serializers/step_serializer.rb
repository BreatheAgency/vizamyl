class StepSerializer < ActiveModel::Serializer
  attributes :id, :position, :title, :page

  def page
    { id: object.page.id, type: object.page.type }
  end
end
