class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :form_step
  cattr_accessor :form_steps do
    %w(details institution terms marketing)
  end

  has_many :progressions, dependent: :destroy
  has_many :steps, through: :progressions

  before_create :create_progressions
  before_save :capitalize_names
  before_save :capitalize_institution
  before_save :check_in_person

  alias_attribute :failed_round_one, :failed_round_one_at
  alias_attribute :failed_round_two, :failed_round_two_at
  alias_attribute :passed_round_one, :passed_round_one_at
  alias_attribute :passed_round_two, :passed_round_two_at

  with_options :if => -> { required_for_step?(:details) } do |step|
    step.validates :salutation, presence: true
    step.validates :first_name, presence: true
    step.validates :last_name, presence: true
    step.validates :email, email: true
    step.validates :invite_code, inclusion: { in: proc { (Rails.application.secrets.invite_codes[I18n.locale.to_s] + ',' + Rails.application.secrets.in_person_codes[I18n.locale.to_s]).split(',') } }, if: Proc.new { form_step == 'details' }
  end

  with_options :if => -> { required_for_step?(:institution) } do |step|
    step.validates :institution, :presence => true
  end

  with_options :if => -> { required_for_step?(:terms) } do |step|
    step.validates :terms_and_conditions_opt_in, inclusion: { in: [true] }
  end

  with_options :if => -> { required_for_step?(:terms) && (I18n.locale == :de || I18n.locale == :'de-at') } do |step|
    step.validates :cookies_opt_in, inclusion: { in: [true] }
  end

  def full_name
    "#{self.salutation} #{self.first_name} #{self.last_name}"
  end

  def latest_step
    latest_progression = progressions.where(amount: 0.5..1).last
    if passed? || latest_progression.nil?
      steps.first
    else
      latest_progression.step
    end
  end

  def pass!
    self.transaction do
      self.progressions.update_all(amount: 1)
      self.passed_round_two = Time.now
      self.save!
    end
  end

  def progress
    return 100 if skippable
    # Count all progressions which are either in progress or complete
    progress = (progressions.where(amount: 0.5..1).count.to_f / progressions.count) * 100.0
    progress.round || 0
  end

  def completed
    return true if skippable
    Step.count == progressions.where(amount: 0.5..1).count
  end
  alias_method :completed?, :completed

  def passed
    !!(skippable || self.passed_round_one || self.passed_round_two)
  end
  alias_method :passed?, :passed

  def failed
    !!(self.failed_round_one || self.failed_round_two)
  end
  alias_method :failed?, :failed

  def skippable
    super_user || in_person
  end
  alias_method :skippable?, :skippable

  def final_assessment_status
    if passed?
      return 'Passed'
    elsif failed_round_one?
      return 'Failed first round'
    elsif failed_round_two?
      return 'Failed second round'
    else
      return 'Not Taken'
    end
  end

  def reset_progress
    self.progressions.update_all(amount: 0)
    self.progressions.where(step: Chapter.first.steps.first).first.update_attribute(:amount, 0.5)
  end

  private

  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?

    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

  def capitalize_institution
    self.institution = institution.capitalize
  end

  def capitalize_names
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end

  def check_in_person
    self.in_person = Rails.application.secrets.in_person_codes[I18n.locale.to_s].include?(self.invite_code)
  end

  def create_progressions
    Chapter.all.map(&:steps).flatten.each_with_index do |step, i|
      # Ensure the first progression is 0.5
      self.progressions.build(step: step, amount: (i === 0) ? 0.5 : 0)
    end
    true
  end

end
