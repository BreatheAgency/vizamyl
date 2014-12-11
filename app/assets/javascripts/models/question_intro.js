Course.QuestionIntro = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'QuestionIntro' } ),
  body: DS.attr('string')
});
