Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['menu'],
  videoId: 'test',

  actions: {
    select: function(chapter, page) {
      this.get('controllers.menu').send('select', chapter, page);
    }
  }
});
