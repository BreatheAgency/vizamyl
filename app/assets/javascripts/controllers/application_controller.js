Course.ApplicationController = Ember.Controller.extend({
  currentLocale: null,
  currentPage: null,
  signedIn: Ember.computed.notEmpty('currentUser'),
  isComplete: Ember.computed.bool('currentUser.completed'),
  isSkippable: Ember.computed.bool('currentUser.skippable'),

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
