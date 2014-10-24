Course.ImagePageController = Ember.ObjectController.extend({
  needs: ['localeCourseMenu'],
  complete: true,
  actions: {
    select: function(chapter, step) {
      this.get('controllers.localeCourseMenu').send('select', chapter, step);
    }
  }
});
