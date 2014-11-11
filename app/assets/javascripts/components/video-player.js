Course.VideoPlayerComponent = Ember.Component.extend({
  maxSecondsSeek: 0,
  timeBeforeChange: 0,

  didInsertElement: function() {
    this.player = window.videojs('player', { nativeControlsForTouch: false, customControlsOnMobile: true, controls: true, preload: true, autoplay: false }, function() {
      this.ga();
    });
    var that = this;
    if (this.mandatory) {
      this.player.on('timeupdate', function(e){
        if (Math.floor(this.currentTime()) > that.get('maxSecondsSeek')) {
          that.player.currentTime(that.get('maxSecondsSeek') - 2);
        } else if (Math.floor(this.currentTime()) == that.get('maxSecondsSeek')) {
          that.incrementProperty('maxSecondsSeek');
        }
        that.set('timeBeforeChange', this.currentTime());
      });
    }
    this.player.one('ended', function(e){
      that.sendAction('finished', true);
    });
  },

  willDestroyElement: function() {
    this.player.off('timeupdate', this.onTimeUpdate);
    this.player.off('ended', this.onEnded);
    this.player.dispose();
  },

  sourceDidChange: function() {
    Ember.run.scheduleOnce('afterRender', this, 'updateSource');
  }.observes('source').on('init'),

  updateSource: function() {
    if (!this.player) { return; } // in case `player` isn't yet initialized
    this.player.src([
      { type: 'application/vnd.apple.mpegurl', src: '//djqy74tsvke0j.cloudfront.net/videos/' + this.get('source') + '/playlist.m3u8' },
      { type: 'video/mp4', src: '//djqy74tsvke0j.cloudfront.net/videos/' + this.get('source') + '/web.mp4' },
      { type: 'video/webm', src: '//djqy74tsvke0j.cloudfront.net/videos/' + this.get('source') + '/web.webm' }
    ]);
    this.player.load();
  }
});
