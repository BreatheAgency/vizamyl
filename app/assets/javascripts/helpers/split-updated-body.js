Ember.Handlebars.registerHelper('split-updated-body', function (body) {
  if (!body || typeof body !== 'string') {
    return '';  // Handle null, undefined, or non-string values
  }

  // Remove the <h2> tag and return the rest of the body
  var updatedBody = body.replace(/<h2>.*?<\/h2>/, '').trim();

  // Check if the updated body is now empty
  if (!updatedBody) {
    return ''; // Return false if no content remains
  }
  

  return new Ember.Handlebars.SafeString(updatedBody);  // Ensures the remaining HTML is rendered safely
});
