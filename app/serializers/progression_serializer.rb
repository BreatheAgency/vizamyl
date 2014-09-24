class ProgressionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :user_id, :step_id
end
