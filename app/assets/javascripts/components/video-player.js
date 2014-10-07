Course.VideoPlayerComponent = Ember.Component.extend({
  didInsertElement: function() {
    this.player = window.videojs('player', { nativeControlsForTouch: false, customControlsOnMobile: true, controls: true, preload: true, autoplay: false });
    if (this.mandatory) {
      var maxSecondsSeek = 0;
      var timeBeforeChange = 0;
      var p = this.player;
      p.on('timeupdate', function(e) {
        if (Math.floor(this.currentTime()) > maxSecondsSeek) {
          p.currentTime(maxSecondsSeek - 2);
        } else if (Math.floor(this.currentTime()) == maxSecondsSeek) {
          maxSecondsSeek += 1;
        }
        timeBeforeChange = this.currentTime();
      });
    }
  },

  willDestroyElement: function() {
    this.player.dispose();
  },

  videoIdDidChange: function() {
    Ember.run.scheduleOnce('afterRender', this, 'updateVideoId');
  }.observes('videoId').on('init'),

  updateVideoId: function() {
    if (!this.player) { return; } // in case `player` isn't yet initialized
    this.player.src([
      { type: 'application/vnd.apple.mpegurl', src: 'http://djqy74tsvke0j.cloudfront.net/' + this.get('videoId') + '/playlist.m3u8' },
      { type: 'video/mp4', src: 'http://djqy74tsvke0j.cloudfront.net/' + this.get('videoId') + '/web.mp4' },
      { type: 'video/webm', src: 'http://djqy74tsvke0j.cloudfront.net/' + this.get('videoId') + '/web.webm' }
    ]);
    this.player.load();
  }
});
