Course.ApplicationController = Ember.Controller.extend({
  currentUser: function() {
    return Course.get('user');
  }.property('Course.user'),

  signedIn:function(){
    this.get('currentUser');
  }.property('currentUser'),

  isSuperUser:function(){
    return this.get('currentUser').get('super_user') || false;
  }.property('currentUser'),
});
