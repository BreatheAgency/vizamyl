Course.ProgressionController = Ember.Controller.extend({
  needs: ['application', 'localeCourseMenu'],
  total: Math.floor((Math.random() * 100) + 1),
  chapters: Ember.computed.alias('controllers.localeCourseMenu.arrangedContent'),
  user: Ember.computed.alias('controllers.application.currentUser'),
  page: Ember.computed.alias('controllers.application.currentPage'),

});
