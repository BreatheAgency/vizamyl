Course.StartRoute = Ember.Route.extend({
  beforeModel: function() {
    this.transitionTo('locale.menu');
  },
});
