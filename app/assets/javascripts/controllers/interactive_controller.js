Course.InteractivePageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  finished: false,

  complete: function(){
    if (this.get('isSuperUser')) {
      return true;
    } else {
      return this.get('finished');
    };
  }.property('finished', 'isSuperUser'),

  columns: function(){
    switch(this.get('model.interactive_sources.length')) {
      case 1:
        return 'small-12 large-12';
        break;
      case 2:
        return 'small-6 large-6';
        break;
      default:
        return 'small-4 large-4';
      }
  }.property('model.interactive_sources.[]'),

  actions: {
    next: function(step) {
      this.get('controllers.localeMenu').send('next', step);
    },

    finished: function(bool) {
      this.set('finished', bool);
    }
  }
});
