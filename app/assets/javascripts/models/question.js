Course.Question = DS.Model.extend({
  title: DS.attr('string'),
  explanation_source: DS.attr('string'),
  test_case: DS.attr('boolean'),
  answers: DS.hasMany('answer'),
  interactive_sources: DS.hasMany('interactive_source'),
  image_sources: DS.hasMany('image_source'),
  answered: false,
  correct: false,
  active: false
});
