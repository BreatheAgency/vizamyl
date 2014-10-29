Course.LocaleCourseMenuController = Ember.ArrayController.extend({
  needs: ['application'],
  sortProperties: ['position'],
  sortAscending: true,

  actions: {

    select: function(chapter, step) {
      var procceed = false,
          progression = step.get('progression'),
          currentUser = this.get('controllers.application').get('currentUser');

        if (chapter.get('available')) {
          console.log('chapter available');

          if (step.get('available')) {
            console.log('step available');
            procceed = true;
          } else {
            console.log('step unavailable');

            var previous_step = chapter.get('steps').objectAt(step.get('position') - 2)
            if (previous_step) {
              console.log('previous_step found');

              if (previous_step.get('completed')) {
                  console.log('previous step completed');
                  procceed = true;
              } else {
                  console.log('previous step not completed');
              }

            } else {
              console.log('previous_step not found');
            }

          }

        } else {
          console.log('chapter unavailable');

          var previous_chapter = this.store.all('chapter').objectAt(chapter.get('position') - 2);
          if (previous_chapter) {
            console.log('previous_chapter found');

            if (previous_chapter.get('completed')) {
                console.log('previous chapter completed');
                procceed = true;
            } else {
                console.log('previous chapter not completed');
            }

          } else {
            console.log('previous_chapter not found');
          }

        }

      if (procceed && !step.get('completed')) {
        progression.set('amount', 0.5);
      }

      // only save the progression when its changed
      if (progression.get('isDirty')) {
        // progression.save();
      }

      // if (procceed) {
        console.log('proceed');
        this.transitionToRoute('pages.index', step.get('page').get('type').dasherize(), step.get('page').get('id'));
      // }

      this.set('open', false);
    }
  }
});
