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
  isJapan: Ember.computed.equal('currentLocale', 'jp'),
  hasAUofQVideo: function() {
    var locale, has_video;

    locale = this.get('currentLocale');
    // TODO: French and Spanish to go
    has_video = (locale === 'it' ||
                 locale === 'de' ||
                 locale === 'de-at' ||
                 locale === 'en-gb' ||
                 locale === 'en');

    return has_video;
  }.property('currentLocale'),

  isEuropean: function() {
    return !(this.get('isUS') || this.get('isJapan'))
  }.property('isUS', 'isJapan'),

  currentStep: function() {
    return this.get('currentPage.step');
  }.property('currentPage'),

  currentChapter: function() {
    return this.get('currentStep.chapter');
  }.property('currentStep'),

  currentUser: function() {
    return Course.get('user');
  }.property('Course.user'),

  currentUserOrigin: function() {
    return Course.get('user.origin');
  }.property('Course.user'),

  currentEnvironment: function() {
    return Course.get('env.environment')
  }.property('Course.env.environment')

});
