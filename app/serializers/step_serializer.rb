class StepSerializer < ActiveModel::Serializer
  attributes :id, :position, :page, :title, :progression_id

  def progression_id
    object.progressions.first_or_create(user: scope).id
  end

  def title
     "#{object.page.title} (#{object.page.subject_area})"
  end

  def page
    { id: object.page_id, type: object.page_type }
  end


end
