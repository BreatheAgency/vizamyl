Course.InteractiveSource = DS.Model.extend({
  label: DS.attr('string'),
  source: DS.attr('string'),
  height: DS.attr('number'),

  sourceWithUrl:function() {
    return '//' + Course.get('env.content-host') + '/interactives/' + this.get('source') + '.jpg';
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
