Course.StartRoute = Ember.Route.extend({
  redirect: function(page, transition) {
    this.transitionTo('menu');
  },
});
