Course.ImageLoaderComponent = Ember.Component.extend({
  src: '',
  loaded: false,
  didInsertElement: function() {
    this.$('.image_wrapper').children('img').one('load', function() {
      this.set('loaded', true);
    }.bind(this));
  }.on('didInsertElement'),
});
