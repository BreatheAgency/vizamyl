Course.ApplicationRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this.controllerFor('menu').set('model', this.store.findAll('chapter'));
  }
});
