class StepSerializer < ActiveModel::Serializer
  attributes :id, :position, :page
  has_one :progression

  def page
    { id: object.page_id, type: object.page_type }
  end

end
