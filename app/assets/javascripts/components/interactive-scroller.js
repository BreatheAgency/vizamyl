Course.InteractiveScrollerComponent = Ember.Component.extend({
  src: '',
  loaded: false,
  imageStep: 0,
  imageHeight: 500,
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
        if (!that.get('drag')) { return; } // in case `drag` isn't yet initialized
        that.set('imageStep', that.get('drag').getStep()[1] - 1);
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

  style: function() {
    return 'height:' + this.get('imageHeightMax') + 'px;';
  }.property('imageHeightMax'),

  onLoaded: function() {
    this.sendAction('finished', true);
    if (this.get('loaded')) {
      this.get('drag').enable();
    } else {
      this.get('drag').disable();
    }
  }.observes('loaded'),

  onScroll: function() {
    Ember.run.scheduleOnce('afterRender', this, function(){
      this.$('.img_wrapper').scrollTo(Math.round((this.get('imageStep')) * this.get('imageHeight')));
    });
  }.observes('imageStep'),
});
