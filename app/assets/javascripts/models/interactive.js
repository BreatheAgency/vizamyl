Course.Interactive = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Interactive' } ),
  body: DS.attr('string'),
  sources: DS.attr(),
  imageHeight: 500,
  steps: 10,

  sourcesWithUrls: function(){
    var sources = this.get('sources') || Ember.A();
    return sources.map(function(source) {
     return '//djqy74tsvke0j.cloudfront.net/interactives/' + source + '.png';
    });
  }.property('sources'),

  imageHeightMax:function () {
    return this.get('steps') * this.get('imageHeight');
  }.property('steps', 'imageHeight'),

});
