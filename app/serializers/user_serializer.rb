class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :locale, :super_user

  def locale
    I18n.locale
  end

end
