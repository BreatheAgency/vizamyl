Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  isSkippable: Ember.computed.alias('controllers.application.isSkippable'),
  finished: Ember.computed.alias('controllers.application.currentStep.completed'),

  complete: function() {
    if (this.get('isSkippable')) { return true; };

    if (this.get('mandatoryOverride')) {
      return this.get('finished');
    } else {
      return true;
    }
  }.property('isSkippable', 'finished', 'mandatoryOverride'),

  mandatoryOverride: function() {
    if (this.get('isSkippable')) { return false; };

    if (this.get('mandatory')) {
      if (this.get('finished')) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }.property('isSkippable', 'finished', 'mandatory'),

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
