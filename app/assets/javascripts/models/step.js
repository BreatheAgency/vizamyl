Course.Step = DS.Model.extend({
  chapter: DS.belongsTo('chapter'),
  progression: DS.belongsTo('progression'),
  position: DS.attr('number'),
  page: DS.belongsTo('page', { polymorphic: true, async: true }),
  title: DS.attr('string'),
  visible: DS.attr('boolean'),

  available: function() {
    return this.get('progression.amount') !== 0;
  }.property('progression.amount'),

  completed: function() {
    return this.get('progression.amount') === 1;
  }.property('progression.amount')
});
