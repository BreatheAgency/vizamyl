Ember.Handlebars.registerHelper('split-heading', function (body) {
  if (!body || typeof body !== 'string') {
    return ''; // Handle null, undefined, or non-string values
  }
  // Try to extract from <h2> first
  let headingMatch = body.match(/<h2>(.*?)<\/h2>/i);
  // If no <h2> found, try <h5>
  if (!headingMatch) {
    headingMatch = body.match(/<h5>(.*?)<\/h5>/i);
  }
  if (!headingMatch) return '';
  // Decode HTML entities
  let div = document.createElement('div');
  div.innerHTML = headingMatch[1];
  let decodedText = div.textContent || div.innerText || '';
  // Return trimmed result
  return decodedText.trim();
});