Course.ProgressionController = Ember.Controller.extend({
  needs: ['application', 'localeMenu'],
  isSandbox: Ember.computed.alias('controllers.application.isSandbox'),
  currentPage: Ember.computed.alias('controllers.application.currentPage'),
  isSkippable: Ember.computed.alias('controllers.application.isSkippable'),
  progressions: Ember.computed.alias('controllers.application.currentUser.progressions'),
  hiddenChapters: Ember.computed.alias('controllers.localeMenu.hiddenChapters'),
  visibleChapters: Ember.computed.alias('controllers.localeMenu.visibleChapters'),

  completeProgressions: function(){
    return this.get('progressions').filter(function(progression, index, self) {
      return progression.get('amount') >= 0.5;
    });
  }.property('progressions.@each.amount'),

  total: function() {
    if (this.get('isSkippable')) { return 100 };
    var total = Math.round((this.get('completeProgressions.length') / this.get('progressions.length')) * 100) || 0;
    return total;
  }.property('isSkippable', 'progressions.length','completeProgressions.length')
});
