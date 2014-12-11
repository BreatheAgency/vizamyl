Course.Text = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Text' } ),
  body: DS.attr('string'),
  abbreviations: DS.attr('string')
});
