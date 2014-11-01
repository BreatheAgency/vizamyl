class Step < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :page, polymorphic: true
  acts_as_list scope: [:chapter_id]
  has_one :progression
  # , ->(s) { where(user_id: 1) }

end
