Course.QuestionIntroPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  complete: true,

  actions: {
    next: function(step) {
      this.get('controllers.localeMenu').send('nextStep', step);
    },
  }
});
