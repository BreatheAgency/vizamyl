Course.Video = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Video' } ),
  mandatory: DS.attr('boolean', { defaultValue: true }),
  source: DS.attr('string'),
  body: DS.attr('string'),
  abbreviations: DS.attr('string')
});
