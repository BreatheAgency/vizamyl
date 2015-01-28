Course.ProgressionController = Ember.Controller.extend({
  needs: ['application', 'localeMenu'],
  chapters: Ember.computed.alias('controllers.localeMenu.visibleChapters'),
  currentPage: Ember.computed.alias('controllers.application.currentPage'),
  progressions: Ember.computed.alias('controllers.application.currentUser.progressions'),
  completeProgressions: Ember.computed.filterBy('progressions', 'amount', 1),

  total: function() {
    var total = (Math.round((this.get('completeProgressions.length') / this.get('progressions.length')) * 100)) || 0;
    return total
  }.property('progressions.[]','completeProgressions.[]')
});
