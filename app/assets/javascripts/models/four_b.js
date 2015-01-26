Course.FourB = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'FourB' } ),
  question_rounds: DS.hasMany('question_round')
});
