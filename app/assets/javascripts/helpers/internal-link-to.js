Ember.Handlebars.registerHelper('internal-link-to', function() {
  return Ember.Handlebars.helpers['link-to'].apply(this, arguments);
});
