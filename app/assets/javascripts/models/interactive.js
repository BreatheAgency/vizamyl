Course.Interactive = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Interactive' } ),
  body: DS.attr('string'),
  sources: DS.attr(),

  sourcesWithUrls: function(){
  var sources = this.get('sources') || Ember.A();
   return sources.map(function(source) {
     return '//djqy74tsvke0j.cloudfront.net/interactives/' + source + '.png';
   });
  }.property('sources'),

  triplet:function (){
    return this.get('sources').get('length') == 3;
  }.property('sources'),

  imageHeight:function () {
    return 500;
  }.property('triplet'),

  imageHeightMax:function () {
    return 5000;
  }.property('triplet'),
});
