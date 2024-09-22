Course.InteractivePageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  complete: true,

  columns: function(){
    switch(this.get('model.interactive_sources.length')) {
    case 1:
      return 'one_slider';
      break;
    case 2:
      return 'two_sliders';
      break;
    default:
      return 'more_sliders';
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
