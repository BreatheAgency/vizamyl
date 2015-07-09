class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :locale, :in_person, :super_user, :failed_round_one_at, :failed_round_two_at, :passed_round_one_at, :passed_round_two_at, :completed
  has_many :progressions
  has_many :steps

  def locale
    I18n.locale
  end

end
