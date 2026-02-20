class UserSerializer < ActiveModel::Serializer
  attributes :user
  has_many :progressions
  has_many :steps

  def locale
    I18n.locale
  end

  def user
    {
      id: object.id,
      email: object.email,
      locale: locale,
      origin: object.origin,
      in_person: object.in_person,
      super_user: object.super_user,
      failed_round_one_at: object.failed_round_one_at,
      failed_round_two_at: object.failed_round_two_at,
      passed_round_one_at: object.passed_round_one_at,
      passed_round_two_at: object.passed_round_one_at,
      completed: object.completed,
      progression_ids: object.progression_ids,
      step_ids: object.step_ids

    }
  end

end
