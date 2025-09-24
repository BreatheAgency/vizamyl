Course.TextPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  complete: true,
  currentLocale: Ember.computed.alias('controllers.application.currentLocale'),

  isJapan: function() {
    return this.get('currentLocale') === 'jp';
  }.property('currentLocale'),

  actions: {
    next: function(step) {
      if (!this.get('complete')) { return; }
      this.get('controllers.localeMenu').send('nextStep', step);
    },
  }
});
