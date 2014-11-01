Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['localeCourseMenu'],
  finished: false,

  complete: function(){
    if (this.get('mandatory')) {
      return this.get('finished');
    } else {
      return true;
    }
  }.property('finished', 'mandatory'),

  actions: {
    next:function(chapter, step) {
      this.get('controllers.localeCourseMenu').send('next', chapter, step);
    },

    finished: function(bool) {
      this.set('finished', bool);
    }
  }
});
