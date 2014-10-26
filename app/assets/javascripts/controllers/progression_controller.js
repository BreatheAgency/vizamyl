Course.ProgressionController = Ember.Controller.extend({
  needs: ['application', 'localeCourseMenu'],
  total: Math.floor((Math.random() * 100) + 1),
  chapters: Ember.A(),

  chapters:function() {
    return this.get('controllers.localeCourseMenu').get('arrangedContent');
  }.property('controllers.localeCourseMenu.arrangedContent'),

});
