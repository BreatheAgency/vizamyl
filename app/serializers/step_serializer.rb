class StepSerializer < ActiveModel::Serializer
  attributes :id, :position, :page, :title, :progression_id

  def progression_id
    object.progressions.where(user: scope).first_or_create.id
  end

  def title
    #  (#{object.page.subject_area})
    "#{object.page.title}"
  end

  def page
    { id: object.page_id, type: object.page_type }
  end


end
