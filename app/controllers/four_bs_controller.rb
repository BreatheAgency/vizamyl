class FourBsController < JsonController
  def show
  @four_b = FourB.includes(
    :translations, question_rounds: [questions: [:translations, :answers, :interactive_sources, :image_sources]]
  ).find(params[:id])

  render json: flatten_four_b(@four_b)
end

private

def flatten_four_b(four_b)
  {
    four_b: {
      id: four_b.id,
      page_id: four_b.page_id,
      type: "FourB",
      title: four_b.subject_area,
      subject_area: four_b.subject_area,
      template_name: "four_b_page",
      controller_name: "four_b_page",
      chapter_id: four_b.chapter.id,
      step_id: four_b.step.id,
      question_round_ids: four_b.question_rounds.pluck(:id)
    },
    steps: [StepSerializer.new(four_b.step, scope: current_user).as_json],
    answers: four_b.question_rounds.flat_map { |round| round.questions.flat_map(&:answers).map { |answer| { id: answer.id, body: answer.body, correct: answer.correct } } },
    image_sources: four_b.question_rounds.flat_map { |round| round.questions.flat_map { |question| question.image_sources.map { |image| { id: image.id, source: image.source } } } },
    interactive_sources: four_b.question_rounds.flat_map { |round| round.questions.flat_map { |question| question.interactive_sources.map { |interactive_source| { id: interactive_source.id, source: interactive_source.source, label: interactive_source.label, height: interactive_source.height } } } },
    questions: four_b.question_rounds.flat_map { |round| round.questions.map { |question| flatten_question(question) } },
    question_rounds: four_b.question_rounds.map { |round| { id: round.id, question_ids: round.questions.pluck(:id) } }
  }
end



def flatten_question(question)
  {
    id: question.id,
    title: question.title,
    explanation_source: question.explanation_source,
    incorrect_title: question.incorrect_title,
    correct_title: question.correct_title,
    test_case: question.test_case,
    answer_ids: question.answers.pluck(:id),
    interactive_source_ids: question.interactive_sources.pluck(:id),
    image_source_ids: question.image_sources.pluck(:id)
  }
end

end
