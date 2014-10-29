class Progression < ActiveRecord::Base
  belongs_to :user
  belongs_to :step

  validates_uniqueness_of :step, scope: :user
  validates :amount, inclusion: { in: [0, 0.5, 1] }
end
