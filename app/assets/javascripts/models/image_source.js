Course.ImageSource = DS.Model.extend({
  source: DS.attr('string'),

  sourceWithUrl:function() {
    return '//vizamyl-live.s3.amazonaws.com/images/' + this.get('source') + '.jpg';
  }.property('source')
});
