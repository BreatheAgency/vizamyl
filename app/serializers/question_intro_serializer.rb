class QuestionIntroSerializer < PageSerializer
  attributes :body

  def controller_name
    'question_intro_page'
  end

  def template_name
    'question_intro_page'
  end
end
