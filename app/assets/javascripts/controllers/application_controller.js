Course.ApplicationController = Ember.Controller.extend({
  currentLocale: null,
  currentPage: null,
  signedIn: Ember.computed.notEmpty('currentUser'),
  isComplete: Ember.computed.bool('currentUser.completed'),

  currentStep: function() {
    return this.get('currentPage.step');
  }.property('currentPage'),

  currentChapter: function() {
    return this.get('currentPage.chapter');
  }.property('currentPage'),

  currentUser: function() {
    return Course.get('user');
  }.property('Course.user'),

  isSuperUser:function(){
    return this.get('currentUser.super_user') || false;
  }.property('currentUser'),

});
