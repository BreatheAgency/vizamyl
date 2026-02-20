Course.LocaleRoute = Ember.Route.extend({
  model: function(params) {
    this.controllerFor('application').set('currentLocale', params.locale);
  },
});
