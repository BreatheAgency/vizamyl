Course.User = DS.Model.extend({
  email: DS.attr('string'),
  super_user: DS.attr('boolean', { defaultValue: false }),
  locale: DS.attr('string'),
  progressions: DS.hasMany('progression'),
});
