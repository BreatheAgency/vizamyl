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

window.Course = Ember.Application.create({
  // LOG_TRANSITIONS: true,
  // LOG_TRANSITIONS_INTERNAL: true,
});
