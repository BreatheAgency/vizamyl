class ProgressionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :user_id, :step_id

  def amount
    if object.user.super_user
      return 1
    else
      return object.amount
    end
  end
end
