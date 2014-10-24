Course.ApplicationRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this.controllerFor('localeCourseMenu').set('model', this.store.findAll('chapter'));
  }
});
