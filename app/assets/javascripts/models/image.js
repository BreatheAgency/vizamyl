Course.Image = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Image' } ),
  source: DS.attr('string'),

  sourceWithUrl: function(){
    return '//' + Course.get('env.content-host') + '/images/' + this.get('source') + '.jpg';
  }.property('source')
});
