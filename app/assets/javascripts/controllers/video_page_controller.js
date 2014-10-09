Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['menu'],
  videoId: 'test',
  mandatory: false,
  finished: false,

  actions: {
    select: function(chapter, page) {
      this.get('controllers.menu').send('select', chapter, page);
    },

    finished: function(bool) {
      this.set('finished', bool);
    }
  }
});
