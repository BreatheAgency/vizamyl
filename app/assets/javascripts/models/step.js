Course.Step = DS.Model.extend({
  chapter: DS.belongsTo('chapter'),
  progression: DS.belongsTo('progression'),
  position: DS.attr('number'),
  page: DS.belongsTo('page', {polymorphic: true}),

  progress: function(){
    this.get('progression').get('amount')
  }.property('progression.amount'),

  available: function() {
    return this.get('progress') !== 0;
  }.property('progress'),

  completed: function() {
    return this.get('progression') === 1;
  }.property('progress'),

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
