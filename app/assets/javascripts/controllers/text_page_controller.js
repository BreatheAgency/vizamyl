Course.TextPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  complete: true,

  actions: {
    next: function(step) {
      if (!this.get('complete')) { return; }
      this.get('controllers.localeMenu').send('nextStep', step);
    },
  }
});
