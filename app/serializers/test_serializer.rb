class TestSerializer < PageSerializer
  has_many :question_sets

  def controller_name
    'test_page'
  end

  def template_name
    'test_page'
  end
end
