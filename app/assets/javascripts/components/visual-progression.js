Course.VisualProgressionComponent = Ember.Component.extend({
  classNames: ['visual-progression'],
  total: 0,

  totalPercent:function(){
    return this.get('total') + '%';
  }.property('total')
});
