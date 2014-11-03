Course.QuestionIntro = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'QuestionIntro' } ),
  body: DS.attr('string'),
});
