Course.LocaleMenuController = Ember.ArrayController.extend({
  needs: ['application'],
  sortProperties: ['position'],
  sortAscending: true,
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),

  actions: {

    toggle:function(chapter){
      var original_selected_state = chapter.get('selected');
      this.get('model').setEach('selected', false);
      chapter.set('selected', !original_selected_state);
    },

    next: function(chapter, step) {
      this.completeStep(step);

      // objectAt becuase the position on the step is not zero based but the steps array on the chapter is
      var next_step = chapter.get('steps').objectAt(step.get('position'));
      if (!next_step) {
        // console.log('next_step not found (eg, get the next chapters step)');
        var next_chapter = this.store.all('chapter').objectAt(chapter.get('position'));
        if (next_chapter.get('available')) {
          chapter = next_chapter;
          next_step = next_chapter.get('steps.firstObject');
          // console.log('next chapter available');
        } else {
          console.log('next chapter unavailable');
        }

      }

      this.send('select', chapter, next_step);
    },

    select: function(chapter, step) {

      if (this.checkStep(chapter, step)) {
        this.transitionToRoute('pages.index', step.get('page').get('type').dasherize(), step.get('page').get('id'));
      } else {
        console.log('check failed?');
      }

      if (!chapter.get('selected')) {
        this.send('toggle', chapter);
      }
    }
  },

  checkStep: function(chapter, step) {
    var procceed = false,
        progression = step.get('progression');

    if (this.get('isSuperUser')) { return true; };

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

    // Only if we're allowed to proceed,
    if (procceed && progression.get('amount') >= 0.5) {
      progression.set('amount', 0.5);
    }

    // only save the progression when its changed
    if (progression.get('isDirty')) {
      progression.save();
    }

    return procceed;
  },

  visibleChapters:function(){
    return this.get('model').filter(function(chapter, index, self) {
      return (chapter.get('visibleSteps.length') !== 0);
    });
  }.property('model.@each.visibleSteps.length'),

  completeStep: function(step) {
    var progression = step.get('progression');
    progression.set('amount', 1);

    // only save the progression when its changed
    if (progression.get('isDirty')) {
      progression.save();
    }
  }
});
