Course.User = DS.Model.extend({
  email: DS.attr('string'),
  super_user: DS.attr('boolean'),
  locale: DS.attr('string'),
  progressions: DS.hasMany('progression'),
  steps: DS.hasMany('steps'),
  completed: DS.attr('boolean'),
  failed_round_one: DS.attr('boolean'),
  failed_round_two: DS.attr('boolean'),
  passed_round_one: DS.attr('boolean'),
  passed_round_two: DS.attr('boolean'),

  passed: function() {
    return this.get('super_user') || this.get('passed_round_one') || this.get('passed_round_two')
  }.property('super_user', 'passed_round_one', 'passed_round_two')
});
