class TestSerializer < PageSerializer
  attributes :failure_step_id, :results_title, :results_incorrect, :results_correct, :optional
  has_many :question_rounds

  def optional
    false
  end

  def controller_name
    'test_page'
  end

  def template_name
    'test_page'
  end
end
