Course.ApplicationAdapter = DS.ActiveModelAdapter.extend({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

Course.ApplicationStore = DS.Store.extend({
  adapter: 'Course.ApplicationAdapter'
});
