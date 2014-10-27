Course.ImageScrollerComponent = Ember.Component.extend({
  src: '',
  loaded: false,
  imageStep: 0,
  imageHeight: 0,
  imageHeightMax: 0,

  didInsertElement: function() {
    var that = this;
    var drag = new Dragdealer(this.$('.dragdealer').get(0), {
      disabled: true,
      horizontal: false,
      vertical: true,
      snap: true,
      y: that.get('imageStep'),
      steps: that.get('imageStepMax'),
      animationCallback: function(x, y) {
        that.set('imageStep', Math.round(y * that.get('imageStepMax')))
      },
    })

    this.set('drag', drag);

    this.$('.img_wrapper').children('img').one('load', function() {
      this.set('loaded', true);
    }.bind(this));

  }.on('didInsertElement'),

  imageStepMax: function() {
    return Math.round(this.get('imageHeightMax') / this.get('imageHeight'));
  }.property('imageHeight', 'imageHeightMax'),

  onLoaded: function() {
    if (this.get('loaded')) {
      this.get('drag').enable();
    } else {
      this.get('drag').disable();
    }
  }.observes('loaded'),

  onScroll: function() {
    Ember.run.scheduleOnce('afterRender', this, function(){
      this.$('.img_wrapper').scrollTo(Math.round((this.get('imageStep')-1) * this.get('imageHeight')));
    });
  }.observes('imageStep'),
});
