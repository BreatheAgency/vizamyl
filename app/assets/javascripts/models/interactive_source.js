Course.InteractiveSource = DS.Model.extend({
  label: DS.attr('string'),
  source: DS.attr('string'),
  height: DS.attr('number'),

  sourceWithUrl:function() {
    return '//djqy74tsvke0j.cloudfront.net/interactives/' + this.get('source') + '.jpg';
  }.property('source')
});
