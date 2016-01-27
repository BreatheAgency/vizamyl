Course.Step = DS.Model.extend({
  chapter: DS.belongsTo('chapter'),
  progression: DS.belongsTo('progression'),
  position: DS.attr('number'),
  page: DS.belongsTo('page', { polymorphic: true, async: true }),
  title: DS.attr('string'),
  visible: DS.attr('boolean'),
  completed: Ember.computed.equal('progression.amount', 1),
  available: Ember.computed.gt('progression.amount', 0)
});
