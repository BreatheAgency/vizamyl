Course.LocaleRoute = Ember.Route.extend({
  model: function(params) {
    this.controllerFor('application').set('locale', params.locale);
  },
  redirect:function(){
    this.transitionTo('locale.menu');
  }
});
