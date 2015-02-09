Course.Chapter = DS.Model.extend({
  position: DS.attr('number'),
  title: DS.attr('string'),
  short_title: DS.attr('string'),
  steps: DS.hasMany('step'),
  hidden: DS.attr('boolean'),
  visibleSteps: Ember.computed.filterBy('steps', 'visible', true),

  progressedSteps: function() {
    return this.get('steps').filter(function(step, index, self) {
      if (step.get('progression').get('amount') > 0) { return true; }
    });
  }.property('steps.@each.progression.amount'),

  completedSteps: function() {
    return this.get('steps').filter(function(step, index, self) {
      if (step.get('progression').get('amount') === 1) { return true; }
    });
  }.property('steps.@each.progression.amount'),

  available: function() {
    return this.get('progressedSteps').get('length') !== 0;
  }.property('progressedSteps'),

  completed: function() {
    return this.get('completedSteps').get('length') === this.get('steps').get('length');
  }.property('completedSteps'),
});
