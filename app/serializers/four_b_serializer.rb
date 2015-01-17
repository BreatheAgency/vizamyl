class FourBSerializer < PageSerializer
  has_many :question_rounds

  def controller_name
    'four_b_page'
  end

  def template_name
    'four_b_page'
  end
end
