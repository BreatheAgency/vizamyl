class PageSerializer < ActiveModel::Serializer
  attributes :id, :page_id, :type, :title, :subject_area, :template_name, :controller_name, :chapter_id, :step_id
  has_one :step

  def type
    object.class.name
  end

  def chapter_id
    object.chapter.id
  end

  def step_id
    object.step.id
  end
end
