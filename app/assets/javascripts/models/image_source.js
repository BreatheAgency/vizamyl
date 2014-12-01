Course.ImageSource = DS.Model.extend({
  source: DS.attr('string'),

  sourceWithUrl:function() {
    return '//djqy74tsvke0j.cloudfront.net/images/' + this.get('source') + '.jpg';
  }.property('source')
});
