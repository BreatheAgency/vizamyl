class TestsController < JsonController
def show
  @test = Test.includes(
    :translations, question_rounds: [questions: [:translations, :answers, :interactive_sources, :image_sources]]
  ).find(params[:id])

  render json: flatten_test(@test)
end

private

def flatten_test(test)
  {
    test: {
      id: test.id,
      page_id: test.page_id,
      type: "Test",
      title: test.subject_area,
      subject_area: test.subject_area,
      template_name: "test_page",
      controller_name: "test_page",
      chapter_id: test.chapter.id,
      failure_step_id: test.failure_step_id,
      results_title: test.results_title,
      results_incorrect: test.results_incorrect,
      results_correct: test.results_correct,
      test_case: test.test_case,
      step_id: test.step.id,
      question_round_ids: test.question_rounds.pluck(:id)
    },
    steps: [StepSerializer.new(test.step, scope: current_user).as_json],
    answers: test.question_rounds.flat_map { |round| round.questions.flat_map(&:answers).map { |answer| { id: answer.id, body: answer.body, correct: answer.correct } } },
    image_sources: test.question_rounds.flat_map { |round| round.questions.flat_map { |question| question.image_sources.map { |image| { id: image.id, source: image.source } } } },
    interactive_sources: test.question_rounds.flat_map { |round| round.questions.flat_map { |question| question.interactive_sources.map { |interactive_source| { id: interactive_source.id, source: interactive_source.source, label: interactive_source.label, height: interactive_source.height } } } },
    questions: test.question_rounds.flat_map { |round| round.questions.map { |question| flatten_question(question) } },
    question_rounds: test.question_rounds.map { |round| { id: round.id, question_ids: round.questions.pluck(:id) } }
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
