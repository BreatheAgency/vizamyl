Course.Test = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Test' } ),
  question_rounds: DS.hasMany('question_round'),
  failure_step_id: DS.attr('number'),
  optional: DS.attr('boolean')
});
