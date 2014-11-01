Course.InteractivePageController = Ember.ObjectController.extend({
  needs: ['localeCourseMenu'],
  complete: true,
  actions: {
    next:function(chapter, step) {
      this.get('controllers.localeCourseMenu').send('next', chapter, step);
    },
  }
});
