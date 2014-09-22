Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['menu'],

  actions: {
    select: function(chapter, page) {
      this.get('controllers.menu').send('select', chapter, page);
    }
  }
});
