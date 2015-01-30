Course.ProgressionController = Ember.Controller.extend({
  needs: ['application', 'localeMenu'],
  hiddenChapters: Ember.computed.alias('controllers.localeMenu.hiddenChapters'),
  visibleChapters: Ember.computed.alias('controllers.localeMenu.visibleChapters'),
  currentPage: Ember.computed.alias('controllers.application.currentPage'),
  progressions: Ember.computed.alias('controllers.application.currentUser.progressions'),

  completeProgressions:function(){
    return this.get('progressions').filter(function(progression, index, self) {
      return progression.get('amount') >= 0.5;
    }.bind(this));
  }.property('progressions.@each.amount'),

  total: function() {
    var total = Math.round(this.get('completeProgressions.length') / (this.get('progressions.length') - this.get('hiddenChapters.lastObject.steps.length')) * 100) || 0;
    return total;
  }.property('progressions.length','completeProgressions.length', 'hiddenChapters.lastObject.steps.length')
});
