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
  }),

  itemId: function() {
    return "accordion-item-".concat(this.id);
  }.property('chapter'),

  headingId: function() {
    return "heading".concat(this.id);
  }.property('chapter'),

  collapseId: function() {
    return "collapse".concat(this.id);
  }.property('chapter'),

  bsTarget: function() {
    if(this.get('available')) {
      return "#collapse".concat(this.id);
    } else {
      'noTarget'
    }
  }.property('chapter'),
});
