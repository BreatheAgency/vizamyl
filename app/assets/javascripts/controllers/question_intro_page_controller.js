Course.QuestionIntroPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  complete: true,

  actions: {
    next: function(step) {
      this.get('controllers.localeMenu').send('nextStep', step);
    },
  }
});
