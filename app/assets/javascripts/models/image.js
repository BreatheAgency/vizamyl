Course.Image = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Image' } ),
  source: DS.attr('string'),

  sourceWithUrl: function(){
    return '//vizamyl-temp-backup.s3.amazonaws.com/images/' + this.get('source') + '.jpg';
  }.property('source')
});
