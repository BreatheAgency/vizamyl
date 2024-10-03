Ember.Handlebars.registerHelper('split-updated-body', function (body) {
  if (!body || typeof body !== 'string') {
    return '';  // Handle null, undefined, or non-string values
  }

  // Remove the <h2> tag and return the rest of the body
  var updatedBody = body.replace(/<h2>.*?<\/h2>/, '');
  return new Ember.Handlebars.SafeString(updatedBody);  // Ensures the remaining HTML is rendered safely
});
