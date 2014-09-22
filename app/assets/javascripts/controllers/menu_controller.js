Course.MenuController = Ember.ArrayController.extend({
  needs: ['application'],
  sortProperties: ['position'],
  sortAscending: true,
  open: true,

  closed: function() {
    return !this.get('open');
  }.property('open'),

  actions: {
    open: function() {
      this.set('open', true);
    },

    close: function() {
      this.set('open', false);
    },

    toggle: function() {
      this.set('open', !this.get('open'));
    },

    select: function(chapter, step) {
      var procceed = false;
      var page = step.get('page');

      console.log(step.get('progression'));

      console.log('chapter available: ' + chapter.get('available'));
      console.log('page available: ' + page.get('available'));

      var currentUser = this.get('controllers.application').get('currentUser')
      var progression = this.store.createRecord('progression', { step: step, user: currentUser });

      if (chapter.get('available') && page.get('available')){
        // progression.set('amount', 1);
        // procceed = true;
      } else if (chapter.get('available') && !page.get('available')) {
      //   // - 2 becuase the page's position is not zero-based and we want the one before it
      //   var previous_page = chapter.get('pages').objectAt(page.get('position') - 2)
      //   if (previous_page && previous_page.get('completed')) {
      //     progression.set('amount', 0.5);
      //     procceed = true;
      //   }
      } else {
      //   // - 2 becuase the chapter's position is not zero-based and we want the one before it
      //   var previous_chapter = this.get('model').objectAt(chapter.get('position') - 2);
      //   if (previous_chapter && previous_chapter.get('completed')) {
      //     progression.set('amount', 0.5);
      //     procceed = true;
      //   }
      }

      // progression.save();

      // if (procceed) {
        // this.transitionToRoute(chapter.get('location') + '.page', page.get('type'), page.get('id'));
      // }

      this.set('open', false);
    }
  }
});
