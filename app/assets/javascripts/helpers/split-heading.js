Ember.Handlebars.registerHelper('split-heading', function (body) {
  
  if (!body || typeof body !== 'string') {
    return '';  // Handle null, undefined, or non-string values
  }

  // Extract the <h2> part
  let headingMatch = body.match(/<h2>(.*?)<\/h2>/);
  return headingMatch ? headingMatch[1] : '';
});
