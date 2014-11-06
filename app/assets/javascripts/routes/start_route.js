Course.StartRoute = Ember.Route.extend({
  activate: function() {
    this.transitionTo('locale.menu');
  },
});
