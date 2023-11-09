Course.VisualProgressionComponent = Ember.Component.extend({
  classNames: ['visual-progression'],
  tagName: 'ul',
  total: 0,

  totalPercent:function(){
    return this.get('total') + '%';
  }.property('total')
});
