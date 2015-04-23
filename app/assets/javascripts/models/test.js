Course.Test = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Test' } ),
  question_rounds: DS.hasMany('question_round'),
  failure_step_id: DS.attr('number'),
  results_title: DS.attr('string'),
  results_correct: DS.attr('string'),
  results_incorrect: DS.attr('string')
});
