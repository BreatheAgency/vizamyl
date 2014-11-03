Course.InteractiveQuestion = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'InteractiveQuestion' } ),
});
