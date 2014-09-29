Course.PagesRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find(params.page_type, params.page_id);
  },

  serialize: function(model) {
    return { page_id: model.id, page_type: model.type };
  },

  // redirect: function(content, transition) {
  //   if (content.get('chapter') && !content.get('chapter').get('available')) {
  //     transition.abort();
  //     // TODO redirect to latest page?
  //     this.transitionTo('index');
  //   }
  // },

  renderTemplate: function(controller, model) {
    this.render(model.get('template_name'), {
      controller: model.get('controller_name'),
      model: model,
      content: model
    });
  }
});
