Course.Step = DS.Model.extend({
  title: DS.attr('string'),
  position: DS.attr('number'),
  page: DS.belongsTo('page', {polymorphic: true}),
  // available: function() {
  //   return this.get('progression.amount') !== 0;
  // }.property('progression.amount'),
  // completed: Ember.aliasMethod('available')
});
