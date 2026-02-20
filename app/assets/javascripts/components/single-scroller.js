Course.SingleScrollerComponent = Ember.Component.extend({
  loaded: false,
  imageStep: 0,
  imageWidth: 0,
  imageHeight: 500,
  imageHeightMax: 0,

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
    this.$('<img>').attr('src', this.get('source')).one('load', function() {
      this.set('loaded', true);
      var image_holder = this.$('.image_holder').detach();
      this.$('.image_wrapper').empty().append(image_holder);
      this.$('.image_holder').css('background-image', "url(" + this.get('source') + ")");
      this.get('drag').enable();
    }.bind(this));
  }.on('didInsertElement'),

  imageStepMax: function() {
    return Math.round(this.get('imageHeightMax') / this.get('imageHeight'));
  }.property('imageHeight', 'imageHeightMax'),

  style: function() {
    return "background-color: black; height:" + this.get('imageHeight') + "px;width:" + this.get('imageWidth') + "px;background-size:" + this.get('imageWidth') + "px " + this.get('imageHeightMax') + "px;" + "background-position:" + "0px 0px;";
  }.property('imageHeight', 'imageHeightMax', 'imageWidth', 'source'),

  onScroll: function() {
    var currentHeight;
    Ember.run.scheduleOnce('afterRender', this, function(){
      currentHeight = Math.round((this.get('imageStep')) * this.get('imageHeight'));
      this.$('.image_holder').css({
        "background-position": "0px " + parseInt(this.get('imageHeightMax') - currentHeight) + "px"
      })
    });
  }.observes('imageStep'),

});
