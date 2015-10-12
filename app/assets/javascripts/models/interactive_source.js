Course.InteractiveSource = DS.Model.extend({
  label: DS.attr('string'),
  source: DS.attr('string'),
  height: DS.attr('number'),
  hasUnsafeHeight: Ember.computed.gte('height', 20000),

  sourceWithUrl:function() {
    return '//' + Course.get('env.content-host') + '/sliders/single/' + this.get('source') + '.jpg';
  }.property('source'),

  images:function () {
    var amount = this.get('height') / 500;
    var images = [];
    for(var i=0; i < amount; i++) {
      images.push('//' + Course.get('env.content-host') + '/sliders/multi/' + this.get('source') + '_' + i + '.jpg');
    }
    return images;
  }.property('source', 'height')
});
