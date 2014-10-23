Course.ProgressionController = Ember.Controller.extend({
  needs: ['application', 'menu'],
  total: Math.floor((Math.random() * 100) + 1),
  chapters: Ember.A(),

  chapters:function(){
    return this.get('controllers.menu').get('model');
  }.property('controllers.menu.model'),

});
