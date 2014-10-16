Course.InteractivePageController = Ember.ObjectController.extend({
  needs: ['menu'],
  complete: true,
  actions: {
    select: function(chapter, step) {
      this.get('controllers.menu').send('select', chapter, step);
    }
  }
});
