Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  finished: Ember.computed.alias('controllers.application.currentStep.completed'),

  complete: function() {
    return true;
    if (this.get('isSuperUser')) { return true; };

    if (this.get('mandatory')) {
      return this.get('finished');
    } else {
      return true;
    }
  }.property('finished', 'mandatory', 'isSuperUser'),

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
