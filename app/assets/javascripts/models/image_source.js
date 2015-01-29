Course.ImageSource = DS.Model.extend({
  source: DS.attr('string'),

  sourceWithUrl:function() {
    return '//dki1hrtf104z9.cloudfront.net/images/' + this.get('source') + '.jpg';
  }.property('source')
});
