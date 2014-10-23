Course.VisualProgressionComponent = Ember.Component.extend({
  classNames: ['visual-progression'],
  total: 0,
  chapters: Ember.A(),

  totalPercent:function(){
    return this.get('total') + '%';
  }.property('total'),

  didInsertElement: function() {
  }.on('didInsertElement'),

  willRemoveElement: function() {
  }.on('willRemoveElement'),
});
