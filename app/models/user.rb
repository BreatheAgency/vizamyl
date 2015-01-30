class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :email, email: true

  attr_accessor :invite_code
  validates :invite_code, inclusion: {in: %w[vzmyl100], message: 'is invalid'}, on: :create

  has_many :progressions
  has_many :steps, through: :progressions

  before_create :create_progressions

  def latest_step
    latest_progression = progressions.where(amount: 0.5..1).last
    if latest_progression.nil?
      steps.first
    else
      return latest_progression.step
    end
  end

  def progress
    return 100 if super_user
    # Count all progressions which are either in progress or complete
    # Subtract all the progressions available aside from the last Chapter (eg extra test case vidoes)
    progress = progressions.where(amount: 0.5..1).count.to_f / (progressions.count - Chapter.last.steps.count) * 100.0
    progress.round || 0
  end

  def completed
    return true if super_user
    Step.count == progressions.where(amount: 0.5..1).count
  end

  def reset_progress
    self.progressions.update_all(amount: 0)
    self.progressions.where(step: Chapter.first.steps.first).first.update_attribute(:amount, 0.5)

    # (Chapter.first.steps | Chapter.second.steps).each do |step|
    #   self.progressions.where(step: step).first.update_attribute(:amount, 1)
    # end
    # self.progressions.where(step: Chapter.third.steps.first).first.update_attribute(:amount, 0.5)
  end

  private

  def create_progressions
    Step.all.each_with_index do |step, i|
      # Ensure the first progression is 0.5
      self.progressions.build(step: step, amount: (i === 0) ? 0.5 : 0)
    end
    true
  end

end
