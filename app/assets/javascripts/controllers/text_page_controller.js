Course.TextPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeCourseMenu'],
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  complete: true,
  actions: {
    next:function(chapter, step) {
      this.get('controllers.localeCourseMenu').send('next', chapter, step);
    },
  }
});
