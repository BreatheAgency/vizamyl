Course.Question = DS.Model.extend({
  title: DS.attr('string'),
  answers: DS.hasMany('answer'),
});
