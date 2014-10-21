Course.ProgressionController = Ember.Controller.extend({
  needs: ['application'],
  total: 100,

  totalPercent:function(){
    return this.get('total') + '%';
  }.property('total')
});
