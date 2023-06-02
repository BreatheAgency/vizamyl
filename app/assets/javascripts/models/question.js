Course.Question = DS.Model.extend({
  title: DS.attr('string'),
  explanation_source: DS.attr('string'),
  test_case: DS.attr('boolean'),
  answers: DS.hasMany('answer'),
  interactive_sources: DS.hasMany('interactive_source'),
  image_sources: DS.hasMany('image_source'),
  answered: false,
  correct: false,
  active: false,
  timeAnswered: 0,
  hasInteractives: Ember.computed.notEmpty('interactive_sources'),
  hasInteractiveTriplet: Ember.computed.equal('interactive_sources.length', 3),
  hasImages: Ember.computed.notEmpty('image_sources'),
  incorrect_title: DS.attr('string'),
  correct_title: DS.attr('string')
});
