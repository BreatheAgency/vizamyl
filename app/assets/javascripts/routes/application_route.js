Course.ApplicationRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this.controllerFor('localeMenu').set('model', this.store.findAll('chapter'));
  },
  actions: {
    error: function(error) {
      Rollbar.error(error);
      console.error(error.message);
      console.error(error.stack);
      // window.location.replace('/404');
    }
  }
});
