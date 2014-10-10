Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['menu'],
  videoId: 'test',
  finished: false,

  complete: function(){
    if (this.get('mandatory')) {
      return this.get('finished');
    } else {
      return true;
    }
  }.property('finished', 'mandatory'),

  actions: {
    select: function(chapter, page) {
      this.get('controllers.menu').send('select', chapter, page);
    },

    finished: function(bool) {
      this.set('finished', bool);
    }
  }
});
