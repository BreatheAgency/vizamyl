class ChapterSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_title, :position, :hidden, :step_ids
  has_many :steps

  def step_ids
    object.steps.ids
  end
end
