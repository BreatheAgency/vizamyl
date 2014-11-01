Course.StartRoute = Ember.Route.extend({
  redirect: function(page, transition) {
    console.log('fpp?');
    this.transitionTo('menu');
  },
});
