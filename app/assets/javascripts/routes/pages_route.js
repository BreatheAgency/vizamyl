Course.PagesRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find(params.page_type, params.page_id);
  },

  afterModel: function(page, transition) {
    if (!page.get('step.available')) {
      this.transitionTo('locale.menu');
    }
  },

  serialize: function(model) {
    return { page_id: model.id, page_type: model.type };
  },

  renderTemplate: function(controller, model) {
    this.controllerFor('application').set('currentPage', model);
    this.render(model.get('template_name'), { controller: model.get('controller_name'), model: model, content: model });
  },

  deactivate: function() {
    if (!this.controllerFor('test_page').get('isInUnanswered')) {
      this.controllerFor('test_page').sendStateEvent('reset');
    }
    this.controllerFor('application').set('currentPage', null);
  },
});
