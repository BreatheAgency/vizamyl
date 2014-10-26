class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :email, email: true

  attr_accessor :invite_code
  validates :invite_code, inclusion: { in: %w[invite], message: 'is invalid'}, on: :create

  has_many :progressions

  def latest_chapter
    latest_step.chapter
  end

  def latest_step
    latest_progression.step
  end

  private

  def latest_progression
    progressions.where(amount: 0.5..1).last
  end

end
