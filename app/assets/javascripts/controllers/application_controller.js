Course.ApplicationController = Ember.Controller.extend({
  currentLocale: null,
  currentPage: null,
  signedIn: Ember.computed.notEmpty('currentUser'),
  isComplete: Ember.computed.bool('currentUser.completed'),
  isSuperUser: Ember.computed.bool('currentUser.super_user'),
  showBlackTriangle: Ember.computed.empty('currentUser.black_triangle_viewed_at'),

  currentStep: function() {
    return this.get('currentPage.step');
  }.property('currentPage'),

  currentChapter: function() {
    return this.get('currentStep.chapter');
  }.property('currentStep'),

  currentUser: function() {
    return Course.get('user');
  }.property('Course.user'),

});
