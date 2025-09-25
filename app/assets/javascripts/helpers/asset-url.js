Ember.Handlebars.registerHelper('asset-url', function (path) {
  // Ensure window.railsAssetPath is defined
  if (window.railsAssetPath && window.railsAssetPath[path]) {
    return window.railsAssetPath[path];
  }
  // Fallback to a default path or empty string
  return '/assets/' + path;
});
