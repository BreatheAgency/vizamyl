Course.WistiaVideo = Ember.View.extend({
  tagName: 'iframe',
  attributeBindings: ['src', 'allowtransparency', 'frameborder', 'scrolling', 'width', 'height'],
  allowtransparency: 'true',
  frameborder: '0',
  scrolling: 'no',
  width: '100%',
  height: '480',
  src: function(){
    return "//fast.wistia.net/embed/iframe/" + this.get('videoId') + "?videoFoam=true&fullscreenButton=false";
  }.property()
});

Ember.Handlebars.helper('wistia-video', Course.WistiaVideo);
