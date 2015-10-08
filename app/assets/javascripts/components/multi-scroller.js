Course.MultiScrollerComponent = Ember.Component.extend({
  loaded: false,
  imageStep: 0,
  imageWidth: 0,
  imageHeight: 500,
  imageHeightMax: 0,
  images: [],

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
    });
    this.set('drag', drag);
    this.$('<img>').attr('src', this.get('firstImage')).one('load', function() {
      this.set('loaded', true);
      var image_holder = this.$('.image_holder').detach();
      this.$('.image_wrapper').empty().append(image_holder);
      this.$('.image_holder').css('background-image', "url(" + this.get('firstImage') + ")");
      this.get('drag').enable();
    }.bind(this));
  }.on('didInsertElement'),

  firstImage: function() {
    return this.get('images.firstObject');
  }.property('images.firstObject'),

  imageStepMax: function() {
    return Math.round(this.get('imageHeightMax') / this.get('imageHeight'));
  }.property('imageHeight', 'imageHeightMax'),

  style: function() {
    return "background-color: black; height:" + this.get('imageHeight') + "px;width:" + this.get('imageWidth') + "px;background-size:" + this.get('imageWidth') + "px " + this.get('imageHeight') + "px;";
  }.property('imageHeight', 'imageHeightMax', 'imageWidth', 'source'),

  onScroll: function() {
    var currentHeight;
    Ember.run.scheduleOnce('afterRender', this, function(){
      this.$('.image_holder').css({
        "background-image": "url(" + this.get('images')[Math.round(this.get('imageStep'))] + ")"
      })
    });
  }.observes('imageStep'),

  preloadImages: function() {
    console.log('preloadImages');
    var unloadedImages = this.get('images');
    var loadedImages = [];
    for (i = 0; i < unloadedImages.length; i++) {
      loadedImages[i] = new Image();
      loadedImages[i].src = unloadedImages[i];
    }
  }.observes('images').on('init')
});
