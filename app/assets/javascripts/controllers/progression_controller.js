Course.ProgressionController = Ember.Controller.extend({
  needs: ['application', 'localeCourseMenu'],
  chapters: Ember.computed.alias('controllers.localeCourseMenu.arrangedContent'),
  user: Ember.computed.alias('controllers.application.currentUser'),
  page: Ember.computed.alias('controllers.application.currentPage'),

  total: function() {
    var progressions = this.get('model');
    var complete_progressions_total = progressions.filterBy('amount', 1).get('length'),
    incomplete_progressions_total = progressions.get('length');
    return (Math.round((complete_progressions_total / incomplete_progressions_total) * 100)) || 0;
  }.property('model','model.@each.amount')
});
