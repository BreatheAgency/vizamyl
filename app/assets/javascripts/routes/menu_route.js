Course.LocaleCourseMenuRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.findAll('chapter');
  }
});
