Course.Interactive = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Interactive' } ),
  body: DS.attr('string'),
  interactive_sources: DS.hasMany('interactive_source')
});
