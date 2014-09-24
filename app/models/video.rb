class Video < ActiveRecord::Base
  self.table_name = 'steps'
  default_scope { where(type: 'Video') }

  belongs_to :chapter
  has_one :progression, foreign_key: :step_id

  translates :title
  # active_admin_translates :title do
  #   validates_presence_of :title
  # end

  def self.create_for_chapter(chapter, attributes = {})
    content = new(attributes)
    if content.valid?
      step = Step.create(type: name, chapter: chapter)
      instance = step.becomes(self)
      instance.update_attributes(attributes)
      instance
    else
      step = content.becomes(Step)
      step.chapter = chapter
      step.type = name
      step.becomes(self)
    end
  end

end
