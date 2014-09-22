class Step < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :page, polymorphic: true, foreign_type: :type, foreign_key: :id
  acts_as_list scope: [:chapter_id]

  has_one :progression

  translates :title
  # active_admin_translates :title do
  #   validates_presence_of :title
  # end

  def self.inheritance_column
    :no_such_column_because_we_dont_want_type_casting
  end

end
