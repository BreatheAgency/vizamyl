Course.LocaleStartRoute = Ember.Route.extend({
  activate: function() {
    var currentUser = this.controllerFor('application').get('currentUser');
    console.log(currentUser.get('progressions'));
    // var latestStep = currentUser.get('progressions').find(function(item, index, enumerable){
    //   console.log(item.get('amount'));
    //   return item.get('amount') == 0.5 || 1
    // });
    // console.log(latestStep);
  },
});
