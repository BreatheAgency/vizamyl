Course.Router.reopen({
  rootURL: '/',
  location: 'auto'
});

Course.Router.map(function() {
  this.route('locale', { path: '/:locale' }, function() {
    this.route('course', function() {
      this.route('menu')
      // this.resource('chapters', { path: '/chapters/:chapter_id' }, function() {
        this.resource('pages', { path: '/:page_type/:page_id' }, function() {
        });
      // });
    });
  });
});
