Course.Step = DS.Model.extend({
  title: DS.attr('string'),
  position: DS.attr('number'),
  page: DS.belongsTo('page', {polymorphic: true}),
  progression: DS.belongsTo('progression'),

  available: function() {
    return this.get('progression').get('amount') !== 0;
  }.property('progression.amount'),

  completed: function() {
    return this.get('progression').get('amount') == 1;
  }.property('progression.amount'),

  progressClass: function(){
    switch(this.get('progression').get('amount')) {
      case 1:
        return 'fi-play-circle';
      case 0.5:
        return 'fi-minus-circle';
      default:
        return 'fi-x-circle';
    }
  }.property('progression.amount'),
});
