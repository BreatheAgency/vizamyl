Course.Text = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Text' } ),
  body: DS.attr('string'),
  abbreviations: DS.attr('string'),
});
