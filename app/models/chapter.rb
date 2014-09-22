class Chapter < ActiveRecord::Base
  has_many :steps, -> { order('position ASC') }
  has_many :images
  has_many :videos

  acts_as_list scope: [:id]

  active_admin_translates :title do
    # validates_presence_of :title
  end
end
