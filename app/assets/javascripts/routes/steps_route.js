Course.StepsRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find(params.step_type, params.step_id);
  },

  serialize: function(model) {
    return { step_id: model.id, step_type: model.type };
  },

  redirect: function(step, transition) {
    if (step.get('chapter') && !step.get('chapter').get('available')) {
      // transition.abort();
      // TODO redirect to latest step?
      // this.transitionTo('start');
    }
  },

  renderTemplate: function(controller, model) {
    this.controllerFor('application').set('currentPage', model);
    this.render(model.get('template_name'), {
      controller: model.get('controller_name'),
      model: model,
      content: model
    });
  }
});
