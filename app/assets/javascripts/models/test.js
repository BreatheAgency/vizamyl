Course.Test = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Test' } ),
});
