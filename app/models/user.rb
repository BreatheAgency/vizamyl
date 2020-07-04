class User < ActiveRecord::Base
  JAPANESE_DEFAULT_INVITE_CODE = Rails
                                  .application
                                  .secrets
                                  .invite_codes
                                  .key({"locale"=>"jp", "origin"=>"jp", "type"=>"default"})

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Singapore & Australian users also share US login screens as they don't have a regional office.
  attr_reader :works_in_us
  def works_in_us=(param)
    @works_in_is = (param == "true")
  end
  # For non-Europeans, who click 1 marketing consent box instead of 3
  attr_reader :marketing_overall_opt_out
  def marketing_overall_opt_out=(param)
    @marketing_overall_opt_out = (param == "1")
  end

  attr_accessor :form_step
  cattr_accessor :form_steps do
    %w(details institution terms marketing)
  end

  has_many :progressions, dependent: :destroy
  has_many :steps, through: :progressions

  before_create :inherit_invitation
  before_create :create_progressions
  before_save :capitalize_names
  before_save :capitalize_institution

  alias_attribute :failed_round_one, :failed_round_one_at
  alias_attribute :failed_round_two, :failed_round_two_at
  alias_attribute :passed_round_one, :passed_round_one_at
  alias_attribute :passed_round_two, :passed_round_two_at

  validates :city_or_state, presence: true, if: Proc.new { @works_in_us }
  validates :primary_specialty, presence: true, if: Proc.new { @works_in_us }

  with_options :if => -> { required_for_step?(:details) } do |step|
    step.validates :salutation, presence: true
    step.validates :first_name, presence: true
    step.validates :last_name, presence: true
    step.validates :email, email: true
    step.validates :invite_code, inclusion: {
      in: proc { Rails.application.secrets.invite_codes },
      if: Proc.new { form_step == 'details' || form_step == nil },
      message: "%{value} is not a valid invite code"
    }
  end

  with_options :if => -> { required_for_step?(:institution) } do |step|
    step.validates :institution, :presence => true
  end

  with_options :if => -> { required_for_step?(:terms) } do |step|
    step.validates :terms_and_conditions_opt_in, inclusion: { in: [true] }
  end

  with_options :if => -> { new_record? && required_for_step?(:terms) && (I18n.locale == :de || I18n.locale == :'de-at') } do |step|
    step.validates :cookies_opt_in, inclusion: { in: [true] }
  end

  with_options :if => -> { new_record? && (I18n.locale == :'en-us' || I18n.locale == :jp) } do |step|
    step.validate :pick_a_marketing_option
    step.validates :privacy_opt_in, inclusion: { in: [true], message: "Please review the privacy statement" }
  end

  def pick_a_marketing_option
    unless marketing_overall_opt_in ^ marketing_overall_opt_out
      errors[:marketing_overall_opt_in] << ""
      errors[:marketing_overall_opt_out] << ""
    end
  end

  def full_name
    "#{self.salutation} #{self.first_name} #{self.last_name}"
  end

  def latest_step
    # Send fast_forward User's to first section page to pre-test cases
    latest_progression = progressions.where(amount: 0.5..1).last
    if passed? || latest_progression.nil?
      steps.first
    elsif fast_forward?
      Step.where(chapter: 9).first
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

  def inherit_invitation
    invitation = Rails.application.secrets.invite_codes[self.invite_code]

    case invitation.fetch('type')
    when 'in_person'
      self.in_person = true
    when 'fast_forward'
      self.fast_forward = true
    end

    self.origin = invitation.fetch('origin')
    self.locale = invitation.fetch('locale')

    true
  end

  def create_progressions
    Chapter.includes(:steps).order(:position).all.each_with_index do |chapter, c_i|
      chapter.steps.flatten.each_with_index do |step, s_i|
        if self.fast_forward && c_i <= 8
          # Ensure that when fast_forward is true that the amount of 1
          self.progressions.build(step: step, amount: 1)
        elsif c_i == 0 && s_i == 0
          # Ensure the first progression is 0.5
          self.progressions.build(step: step, amount: 0.5)
        else
          # Else
          self.progressions.build(step: step, amount: 0)
        end
      end
    end

    true
  end

end
