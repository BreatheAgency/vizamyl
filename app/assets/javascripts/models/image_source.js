Course.ImageSource = DS.Model.extend({
  source: DS.attr('string'),

  sourceWithUrl:function() {
    return '//' + Course.get('env.content-host') + '/images/' + this.get('source') + '.jpg';
  }.property('source')
});
