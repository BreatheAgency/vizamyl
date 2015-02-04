Course.User = DS.Model.extend({
  email: DS.attr('string'),
  super_user: DS.attr('boolean'),
  locale: DS.attr('string'),
  progressions: DS.hasMany('progression'),
  steps: DS.hasMany('steps'),
  completed: DS.attr('boolean'),
  failed_round_one_at: DS.attr('date'),
  failed_round_two_at: DS.attr('date'),
  passed_round_one_at: DS.attr('date'),
  passed_round_two_at: DS.attr('date'),
  failedRoundOne: Ember.computed.notEmpty('failed_round_one_at'),
  failedRoundTwo: Ember.computed.notEmpty('failed_round_two_at'),
  passedRoundOne: Ember.computed.notEmpty('passed_round_one_at'),
  passedRoundTwo: Ember.computed.notEmpty('passed_round_two_at'),

  passed: function() {
    return this.get('super_user') || this.get('passedRoundOne') || this.get('passedRoundTwo')
  }.property('super_user', 'passedRoundOne', 'passedRoundTwo')
});
