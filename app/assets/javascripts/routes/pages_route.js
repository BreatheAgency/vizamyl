Course.PagesRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find(params.page_type, params.page_id);
  },

  serialize: function(model) {
    return { page_id: model.id, page_type: model.type };
  },

  redirect: function(page, transition) {
    if (page.get('chapter') && !page.get('chapter').get('available')) {
      // transition.abort();
      // TODO redirect to latest page?
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
