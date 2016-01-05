Course.ApplicationController = Ember.Controller.extend({
  isDevelopment: Ember.computed.equal('currentEnvironment', 'development'),
  isSandbox: Ember.computed.equal('currentEnvironment', 'sandbox'),
  isProduction: Ember.computed.equal('currentEnvironment', 'production'),
  currentLocale: null,
  currentPage: null,
  signedIn: Ember.computed.notEmpty('currentUser'),
  isComplete: Ember.computed.bool('currentUser.completed'),
  isSkippable: Ember.computed.bool('currentUser.skippable'),
  isUS: Ember.computed.equal('currentLocale', 'en-us'),

  currentStep: function() {
    return this.get('currentPage.step');
  }.property('currentPage'),

  currentChapter: function() {
    return this.get('currentStep.chapter');
  }.property('currentStep'),

  currentUser: function() {
    return Course.get('user');
  }.property('Course.user'),

  currentEnvironment: function() {
    return Course.get('env.environment')
  }.property('Course.env.environment')

});
