Course.Router.reopen({
  rootURL: '/',
  location: 'auto'
});

Course.Router.map(function() {
  this.route('locale', { path: '/:locale' }, function() {
    this.route('course', function() {
      this.route('start');
      this.resource('chapters', { path: '/chapters/:chapter_id' }, function() {
        this.resource('steps', { path: '/:step_type/:step_id' }, function() {
        });
      });
    });
  });
});
