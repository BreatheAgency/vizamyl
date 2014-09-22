Course.Progression = DS.Model.extend({
  user: DS.belongsTo('user'),
  step: DS.belongsTo('step'),
  amount: DS.attr('number')
});
