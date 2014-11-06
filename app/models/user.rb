class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :email, email: true

  attr_accessor :invite_code
  validates :invite_code, inclusion: { in: %w[vzmyl100], message: 'is invalid'}, on: :create

  has_many :progressions

  def latest_step
    latest_progression.step
  end

  def progress
    return 100 if super_user
    progress = progressions.where(amount: 1).count.to_f / progressions.count.to_f * 100.0
    progress.round || 0
  end

  # TODO
  # def completed
  #   return true if super_user
  #   Step.count == progressions.where(amount: 1).count
  # end

  private

  def latest_progression
    progressions.where(amount: 0.5..1).last
  end

end
