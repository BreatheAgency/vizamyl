class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :locale, :super_user, :completed
  has_many :progressions
  has_many :steps

  def locale
    I18n.locale
  end

end
