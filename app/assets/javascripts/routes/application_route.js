Course.ApplicationRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this.controllerFor('localeMenu').set('model', this.store.findAll('chapter'));
    this.controllerFor('progression').set('model', this.store.findAll('progression'));
  }
});
