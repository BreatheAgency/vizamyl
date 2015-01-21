Course.LocaleMenuRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.findAll('chapter');
  },
});
