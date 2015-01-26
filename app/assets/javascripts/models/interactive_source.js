Course.InteractiveSource = DS.Model.extend({
  label: DS.attr('string'),
  source: DS.attr('string'),
  height: DS.attr('number'),

  sourceWithUrl:function() {
    return '//vizamyl-live.s3.amazonaws.com/interactives/' + this.get('source') + '.jpg';
  }.property('source')
});
