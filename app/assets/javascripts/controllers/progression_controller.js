Course.ProgressionController = Ember.Controller.extend({
  needs: ['application', 'localeMenu'],
  chapters: Ember.computed.alias('controllers.localeMenu.visibleChapters'),
  user: Ember.computed.alias('controllers.application.currentUser'),
  page: Ember.computed.alias('controllers.application.currentPage'),
  progressions: Ember.computed.alias('controllers.application.currentUser.progressions'),
  completeProgressions: Ember.computed.filterBy('progressions', 'amount', 1),

  total: function() {
    console.log('Progressions ' + this.get('progressions.length'));
    console.log('Complete Progressions ' + this.get('completeProgressions.length'));
    var total = (Math.round((this.get('completeProgressions.length') / this.get('progressions.length')) * 100)) || 0;
    console.log('Total ' + total);
    return total
  }.property('progressions.[]','completeProgressions.[]')
});
