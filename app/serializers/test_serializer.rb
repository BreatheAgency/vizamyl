class TestSerializer < PageSerializer
  attributes :failure_step_id, :optional
  has_many :question_rounds

  def controller_name
    'test_page'
  end

  def template_name
    'test_page'
  end
end
