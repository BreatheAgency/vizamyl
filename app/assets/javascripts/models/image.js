Course.Image = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Image' } ),
  source: DS.attr('string'),

  sourceWithUrl: function(){
    return '//djqy74tsvke0j.cloudfront.net/images/' + this.get('source') + '.jpg';
  }.property('source')
});
