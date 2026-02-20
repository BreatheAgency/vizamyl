Course.ImageTogglerComponent = Ember.Component.extend({
  tagName: 'img',
  attributeBindings: ['src'],
  classNameBindings: ['isScrolled:hide:show'],
  src: Ember.computed.oneWay('source'),
  isScrolled: function() {
    return this.get('source') !== this.get('selectedImage')
  }.property('source', 'selectedImage')
});
