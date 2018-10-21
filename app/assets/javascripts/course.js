//= require underscore
//= require es5-shim/es5-shim
//= require video
//= require ./videojs.ga
//= require ./dragdealer
//= require handlebars
//= require ember
//= require ember-data
//= require i18n
//= require i18n/translations
//= require ./ember-fsm
//= require ./ember-google-analytics
//= require ./ember-string-interpolate
//= require_self
//= require ./router
//= require ./store
//= require_tree ./mixins
//= require_tree ./helpers
//= require_tree ./controllers
//= require ./models/page
//= require_tree ./models
//= require_tree ./routes
//= require_tree ./views
//= require_tree ./components
//= require_tree ./templates
//= require_tree ./initializers

I18n.fallbacks = true;
// I18n.locales.at = ["de", "en"];
I18n.missingTranslationPrefix = '?: '

window.Course = Ember.Application.create({
  env: Em.Object.create(),
  // LOG_TRANSITIONS: true,
  // LOG_TRANSITIONS_INTERNAL: true,
});

Ember.RSVP.configure('onerror',function(error) {
  try {
    Rollbar.error(error);
  } catch(err) {}
});

window.onerror = function(error) {
  try {
    Rollbar.error(error);
  } catch(err) {}
};

// Deleteing this empty function declaration breaks error bubbling
Ember.onerror = function (error) {};

Ember.RSVP.on('error', function (error) {
  if(error && error.status && error.status == 401) {
    // User is not logged in
    window.location = '/';
  }
});
