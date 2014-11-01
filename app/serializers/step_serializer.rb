class StepSerializer < ActiveModel::Serializer
  # delegate :current_user, to: :scope
  attributes :id, :position, :page
  has_one :progression

  #
  # def progression
  #   object.progressions.where(user: current_user)
  # end

  def page
    { id: object.page_id, type: object.page_type }
  end

end
