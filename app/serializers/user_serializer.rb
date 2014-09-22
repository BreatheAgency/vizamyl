class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :locale

  def locale
    I18n.locale
  end
end
