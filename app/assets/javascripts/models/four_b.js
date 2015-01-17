Course.FourB = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Test' } ),
  question_rounds: DS.hasMany('question_round')
});
