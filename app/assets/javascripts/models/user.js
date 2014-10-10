Course.User = DS.Model.extend({
  email: DS.attr('string'),
  locale: DS.attr('string'),
  progressions: DS.hasMany('progression')
});
