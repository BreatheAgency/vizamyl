Course.Chapter = DS.Model.extend({
  position: DS.attr('number'),
  title: DS.attr('string'),
  short_title: DS.attr('string'),
  steps: DS.hasMany('step'),
  hidden: DS.attr('boolean'),
  visibleSteps: Ember.computed.filterBy('steps', 'visible', true),

  progressedSteps: Ember.computed('steps.@each.progression.amount', function() {
    var steps = this.get('steps');
    return steps.filter(function(step, index, self) {
      if (step.get('progression.amount') > 0) {
         return true;
       } else {
         return false;
       }
    });
  }),

  completedSteps: Ember.computed('steps.@each.progression.amount', function() {
    var steps = this.get('steps');
    return steps.filter(function(step, index, self) {
      if (step.get('progression.amount') === 1) {
         return true;
       } else {
         return false;
       }
    });
  }),

  available: Ember.computed('progressedSteps.length', function() {
    return this.get('progressedSteps.length') !== 0;
  }),

  completed: Ember.computed('completedSteps.length', 'steps.length', function() {
    return this.get('completedSteps.length') === this.get('steps.length');
  })
});
