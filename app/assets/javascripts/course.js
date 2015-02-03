//= require ./videojs.ga
//= require ./dragdealer
//= require handlebars
//= require ember
//= require ember-data
//= require i18n
//= require i18n/translations
//= require ./ember-fsm
//= require ./ember-google-analytics
//= require_self
//= require ./router
//= require ./store
//= require_tree ./helpers
//= require_tree ./controllers
//= require ./models/page
//= require_tree ./models
//= require_tree ./routes
//= require_tree ./views
//= require_tree ./components
//= require_tree ./templates
//= require_tree ./initializers
window.Course = Ember.Application.create({
  env: Em.Object.create(),
  // LOG_TRANSITIONS: true,
  // LOG_TRANSITIONS_INTERNAL: true,
});

// Safety net to report any untrapped exceptions on browsers
// that respect window.onerror.  Currently, failures from within
// Backburner callbacks will end up here. This is inferior to the
// other handlers because the stack trace is missing by the
// time the exception gets here.
window.onerror = function report_error(error) {
  Rollbar.error(error);
  // window.location.replace('/404');
};

// Trap exceptions from within Ember run loop
Ember.onerror = window.onerror;

// Trap unhandled RSVP promise failures
Ember.RSVP.configure('onerror', window.onerror);
