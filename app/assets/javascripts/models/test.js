Course.Test = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Test' } ),
  question_rounds: DS.hasMany('question_round'),
  failure_step: DS.belongsTo('step')
});
