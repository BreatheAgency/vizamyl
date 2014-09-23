Course.ApplicationController = Ember.Controller.extend({
  needs: ['menu'],
  currentUser: function() {
    return Course.get('user');
  }.property('Course.user'),

  signedIn:function(){
    this.get('currentUser');
  }.property('currentUser')
});
