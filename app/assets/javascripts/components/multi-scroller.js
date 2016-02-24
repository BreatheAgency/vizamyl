Course.MultiScrollerComponent = Ember.Component.extend({
  loaded: false,
  imageStep: 0,
  imageWidth: 0,
  imageHeight: 500,
  imageHeightMax: 0,
  images: [],

  labelStyle: function(){
    return 'min-width:' + this.get('imageWidth') + 'px;'
  }.property('imageWidth'),

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
    this.$('<img>').attr('src', this.get('lastImage')).one('load', function() {
      var image_holder = this.$('.image_holder').detach();
      this.$('.image_wrapper').empty().append(image_holder);
      this.set('loaded', true);
      this.get('drag').enable();
    }.bind(this));
  }.on('didInsertElement'),

  lastImage: function() {
    return this.get('images.lastObject');
  }.property('images.lastObject'),

  imageStepMax: function() {
    return Math.round(this.get('imageHeightMax') / this.get('imageHeight'));
  }.property('imageHeight', 'imageHeightMax'),

  style: function() {
    return "background-color: black; height:" + this.get('imageHeight') + "px;width:" + this.get('imageWidth') + "px;" + this.get('imageHeight') + "px;";
  }.property('imageHeight', 'imageHeightMax', 'imageWidth', 'source'),

  selectedImage: function(){
    return this.get('images')[Math.round(this.get('imageStep'))];
  }.property('images', 'imageStep')
});
