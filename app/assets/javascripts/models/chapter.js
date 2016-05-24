Course.Chapter = DS.Model.extend({
  position: DS.attr('number'),
  title: DS.attr('string'),
  short_title: DS.attr('string'),
  steps: DS.hasMany('step'),
  hidden: DS.attr('boolean'),
  visibleSteps: Ember.computed.filterBy('steps', 'visible', true),
  availableSteps: Ember.computed.filterBy('steps', 'available', true),
  completedSteps: Ember.computed.filterBy('steps', 'completed', true),

  available: Ember.computed('availableSteps.length', function() {
    return this.get('availableSteps.length') !== 0;
  }),

  completed: Ember.computed('completedSteps.length', 'steps.length', function() {
    return this.get('completedSteps.length') === this.get('steps.length');
  })
});
