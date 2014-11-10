Course.Step = DS.Model.extend({
  chapter: DS.belongsTo('chapter'),
  progression: DS.belongsTo('progression'),
  position: DS.attr('number'),
  page: DS.belongsTo('page', { polymorphic: true }),
  title: DS.attr('string'),
  visible: DS.attr('boolean'),

  available: function() {
    return this.get('progression.amount') !== 0;
  }.property('progression.amount'),

  completed: function() {
    return this.get('progression.amount') === 1;
  }.property('progression.amount'),

  progressClass: function(){
    switch(this.get('progression.amount')) {
      case 1:
        return 'fi-checkbox';
      case 0.5:
        return 'fi-contrast';
      default:
        return 'fi-x-circle';
    }
  }.property('progression.amount'),
});
