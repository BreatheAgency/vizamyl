Course.InteractiveSource = DS.Model.extend({
  label: DS.attr('string'),
  source: DS.attr('string'),
  height: DS.attr('number'),

  sourceWithUrl:function() {
    return '//' + Course.get('env.content-host') + '/interactives/' + this.get('source') + '.jpg';
  }.property('source')
});
