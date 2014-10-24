Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['localeCourseMenu'],
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
      this.get('controllers.localeCourseMenu').send('select', chapter, page);
    },

    finished: function(bool) {
      this.set('finished', bool);
    }
  }
});
