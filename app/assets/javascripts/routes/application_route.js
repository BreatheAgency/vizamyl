Course.ApplicationRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this.controllerFor('localeCourseMenu').set('model', this.store.findAll('chapter'));
    this.controllerFor('progression').set('model', this.store.findAll('progression'));
  }
});
