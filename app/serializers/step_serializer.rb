class StepSerializer < ActiveModel::Serializer
  attributes :id, :position, :page, :progression_id

  def progression_id
    object.progressions.where(user: scope).first.id
  end

  def page
    { id: object.page_id, type: object.page_type }
  end

end
