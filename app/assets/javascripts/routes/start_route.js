Course.LocaleStartRoute = Ember.Route.extend({
  activate: function() {
    var user = this.controllerFor('application').get('currentUser');
    var progressions = user.get('progressions').toArray().reverse();
    var step = progressions.find(function(item, index, enumerable){
      return (Ember.get(item, 'amount') != 0);
    });
    console.log(progressions.get('firstObject.step'));
    console.log(step);
    console.log(step.get('page'));
    // console.log(step.get('page.type'));
    // console.log(step.get('page.id'));
    // this.transitionToRoute('pages.index', step.get('page.type').dasherize(), step.get('page.id'));
    // console.log(step.get('page.type').dasherize());
    // console.log(step.get('page.id'));
  },
});
