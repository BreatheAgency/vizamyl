Course.Step = DS.Model.extend({
  chapter: DS.belongsTo('chapter'),
  progression: DS.belongsTo('progression'),
  position: DS.attr('number'),
  page: DS.belongsTo('page', {polymorphic: true}),

  available: function() {
    return this.get('progression.amount') !== 0;
  }.property('progression.amount'),

  completed: function() {
    return this.get('progression.amount') === 1;
  }.property('progression.amount'),

  progressClass: function(){
    switch(this.get('progress')) {
      case 1:
        return 'fi-checkbox';
      case 0.5:
        return 'fi-contrast';
      default:
        return 'fi-x-circle';
    }
  }.property('progress'),
});
