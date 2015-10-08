Ember.Application.initializer({
  name: 'bootstrap',
  after: 'store',
  initialize: function(container, application) {
    var store = container.lookup('store:main');
    var data = JSON.parse($('meta[name="bootstrap"]').attr('content'));
    var user = store.push('user', store.normalize('user', data['user']));
    store.pushMany('step', store.normalize('step', data['steps']));
    store.pushMany('progression', store.normalize('progression', data['progressions']));
    Course.set('user', user);
    I18n.locale = user.get('locale');
    try {
      Rollbar.configure({
        payload: {
          person: {
            email: Course.get('user.email')
          }
        }
      });
    } catch(err) {}
  }
});
