Course.Test = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Test' } ),
  question_sets: DS.hasMany('question_set'),
});
