Course.LocaleRoute = Ember.Route.extend({
  queryParams: {
    origin: {
      refreshModel: false
    }
  },

  model: function(params, transition) {
    console.log('Params received in model():', params);
    console.log('Transition queryParams:', transition.queryParams);

    var appController = this.controllerFor('application');

    // Set the locale
    appController.set('currentLocale', params.locale);

    // Set origin from query params
    var origin = (transition && transition.queryParams && transition.queryParams.origin) || params.origin;
    if (origin && !appController.get('currentOrigin')) {
      appController.set('currentOrigin', origin);
      console.log('Origin set in Ember app:', origin);
    }
  }
});
