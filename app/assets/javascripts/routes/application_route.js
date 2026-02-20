Course.ApplicationRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this.controllerFor('localeMenu').set('model', this.store.findAll('chapter'));
  },
  actions: {
    error: function(error) {
      Rollbar.error(error);
      // window.location.replace('/404');
    }
  }
});
