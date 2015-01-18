Course.VideoPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  finished: false,

  complete: function(){
    if (this.get('isSuperUser')) { return true; };

    if (this.get('mandatory')) {
      return this.get('finished');
    } else {
      return true;
    }
  }.property('finished', 'mandatory', 'isSuperUser'),

  actions: {
    next: function(step) {
      this.get('controllers.localeMenu').send('next', step);
    },

    finished: function(bool) {
      this.set('finished', bool);
    }
  }
});
