Course.Interactive = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Interactive' } ),
  body: DS.attr('string'),
  interactive_sources: DS.hasMany('interactive_source'),
});
