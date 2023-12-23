Course.InteractiveSource = DS.Model.extend({
  label: DS.attr('string'),
  source: DS.attr('string'),
  height: DS.attr('number'),
  hasUnsafeHeight: Ember.computed.gte('height', 20000), // At the time of writing, 151 out of 161 meet this condition

  // Called if hasUnafeHeight == false
  // This was the way it was originally done. Load one tall image with all frames included.
  // Have a look on S3 at one of the images to see what that means.
  sourceWithUrl:function() {
    return '//' + Course.get('env.content-host') + '/sliders/single/' + this.get('source') + '.jpg';
  }.property('source'),

  // Called if hasUnafeHeight == true
  // This looks like it was a bugfix for very tall images. The big image got broken into separate images 500px
  // tall each.
  images:function () {
    var amount = this.get('height') / 500;
    var images = [];
    for(var i=0; i < amount; i++) {
      images.push('//' + Course.get('env.content-host') + '/sliders/multi/' + this.get('source') + '_' + i + '.jpg');
    }
    return images;
  }.property('source', 'height')
});
