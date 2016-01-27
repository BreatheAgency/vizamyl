Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  isSkippable: Ember.computed.alias('controllers.application.isSkippable'),
  finished: Ember.computed.alias('controllers.application.currentStep.completed'),

  complete: function() {
    if (this.get('isSkippable')) { return true; };

    if (this.get('mandatory')) {
      return this.get('finished');
    } else {
      return true;
    }
  }.property('isSkippable', 'finished', 'mandatory'),

  super_mandatory: function() {
    // if (this.get('isSkippable')) { return false; };
    // return this.get('mandatory');
    return false;
  }.property('mandatory'),

  actions: {
    next: function(step) {
      if (!this.get('complete')) { return; }
      this.get('controllers.localeMenu').send('nextStep', step);
    },

    finished: function(bool) {
      this.set('finished', bool);
    }
  }
});
