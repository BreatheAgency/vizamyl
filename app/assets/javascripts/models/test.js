Course.Test = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Test' } ),
  question_rounds: DS.hasMany('question_round'),
  failure_step: DS.belongsTo('step'),
});
