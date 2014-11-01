class PageSerializer < ActiveModel::Serializer
  attributes :id, :type, :title, :subject_area, :template_name, :controller_name, :chapter_id
  has_one :progression
  has_one :step

  def type
    object.class.name
  end

  def chapter_id
    object.chapter.id
  end
end
