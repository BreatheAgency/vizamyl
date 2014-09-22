Course.Router.reopen({
  rootURL: '/course/',
  location: 'auto'
});

Course.Router.map(function() {
  this.resource('chapters', function() {
    this.resource('introduction', function() {
      this.route('page', { path: '/:page_type/:page_id' });
    });
    this.resource('one-a', function() {
      this.route('page', { path: '/:page_type/:page_id' });
    });
  });
});
