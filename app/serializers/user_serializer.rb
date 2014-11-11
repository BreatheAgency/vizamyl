class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :locale, :super_user
  has_many :progressions

  def locale
    I18n.locale
  end

end
