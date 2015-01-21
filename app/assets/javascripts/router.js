Course.Router.reopen({
  rootURL: '/course/',
  location: 'auto'
});

Course.Router.map(function() {
  this.route('locale', { path: '/:locale' }, function() {
    this.route('menu');
    this.resource('pages', { path: '/:page_type/:page_id' }, function() {
    });
  });
});
