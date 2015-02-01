class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :locale, :super_user, :failed_round_one, :failed_round_two, :passed_round_one, :passed_round_two
  has_many :progressions
  has_many :steps

  def locale
    I18n.locale
  end

end
