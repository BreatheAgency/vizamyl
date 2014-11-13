Course.QuestionSet = DS.Model.extend({
  title: DS.attr('string'),
  questions: DS.hasMany('question'),
});
