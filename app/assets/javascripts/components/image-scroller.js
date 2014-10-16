Course.ImageScrollerComponent = Ember.Component.extend({
  src: '',
  loaded: false,
  rangeMin: 0,
  rangeMax: 100,
  rangeValue: 100,

  didInsertElement: function() {
    this.$('.img_wrapper').children('img').bind('load', function() {
      this.set('loaded', true);
    }.bind(this));
  }.on('didInsertElement'),

  willRemoveElement: function() {
  }.on('willRemoveElement'),

  scrollPosition: function(){
    return this.get('rangeValue');
  }.property('rangeValue'),

  onScroll: function() {
    console.log(this.get('scrollPosition'));
    Ember.run.throttle(this, function() {
      Ember.run.scheduleOnce('afterRender', this, function(){
        this.$('.img_wrapper').scrollTo(this.get('scrollPosition'));
      });
    }, 300, false);
  }.observes('rangeValue'),
});
