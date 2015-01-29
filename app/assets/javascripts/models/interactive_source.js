Course.InteractiveSource = DS.Model.extend({
  label: DS.attr('string'),
  source: DS.attr('string'),
  height: DS.attr('number'),

  sourceWithUrl:function() {
    return '//dki1hrtf104z9.cloudfront.net/interactives/' + this.get('source') + '.jpg';
  }.property('source')
});
