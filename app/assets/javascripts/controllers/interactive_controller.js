Course.InteractivePageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  complete: true,

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

  interactiveWidth: function() {
    switch(this.get('model.interactive_sources.length')) {
      case 1:
        return 521;
        break;
      case 2:
        return 230
        break;
      default:
        return 163;
    }
  }.property('model.interactive_sources.[]'),

  actions: {
    next: function(step) {
      if (!this.get('complete')) { return; }
      this.get('controllers.localeMenu').send('nextStep', step);
    }
  }
});
