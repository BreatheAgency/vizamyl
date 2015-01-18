Ember.Application.initializer({
  name: 'user',
  after: 'store',
  initialize: function(container, application) {
    var store = container.lookup('store:main');
    var attributes = JSON.parse($('meta[name="user"]').attr('content'));
    var user = store.push('user', attributes);
    Course.set('user', user);
    I18n.locale = user.get('locale');
  }
});
