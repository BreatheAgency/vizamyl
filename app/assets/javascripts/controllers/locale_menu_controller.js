Course.LocaleMenuController = Ember.ArrayController.extend({
  needs: ['application'],
  sortProperties: ['position'],
  sortAscending: true,
  isComplete: Ember.computed.alias('controllers.application.isComplete'),
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),

  actions: {

    toggle: function(chapter){
      if (!chapter.get('available')) { return; }
      var originalSelectedState = chapter.get('selected');
      this.get('model').setEach('selected', false);
      chapter.set('selected', !originalSelectedState);
    },

    selectStep: function(step) {
      // check the step's availabilty
      if(!step.get('available')) { return; }

      console.log(step);
      console.log(step.get('page'));
      if (step.get('page') == undefined){
        debugger;
      }
      console.log(step.get('page.type'));
      console.log(step.get('page.id'));
      console.log(step.get('page.type').dasherize());

      // go to the step's page
      this.transitionToRoute('pages.index', step.get('page.type').dasherize(), step.get('page.id'));

      // ensure the menu is showing correct the correct chapter being open
      if (!step.get('chapter.selected')) {
        this.send('toggle', step.get('chapter'));
      }

    },

    nextStep: function(previousStep) {

      var previousChapter = previousStep.get('chapter');
      var previousStepIndex = previousChapter.get('steps').indexOf(previousStep);
      var nextStep = null;

      // update steps's progression
      this.updateProgression(previousStep.get('progression'), 1);

      // if the step is the last in the chapter's steps then we need to get the next chapter
      // else the step is currently part of the chapter so we can simple select the next one
      if (previousStepIndex === (previousChapter.get('steps.length') - 1)) {
        var nextChapter = this.get('arrangedContent').objectAt(previousChapter.get('position'));
        // if the nextChapter is not found, its because we've reached the end of the course, so lets send them back to the first step in the chapter
        // else get it's first step
        if (nextChapter == undefined) {
          nextStep = previousChapter.get('steps.firstObject');
        } else {
          nextStep = nextChapter.get('steps.firstObject');
        }
      } else {
        nextStep = previousChapter.get('steps').objectAt(previousStepIndex + 1);
      }

      // update the next step's progression
      this.updateProgression(nextStep.get('progression'), 0.5);

      this.send('selectStep', nextStep);

    },

    // next: function(step) {
    //   var chapter = step.get('chapter');
    //   this.completeStep(step);
    //
    //   // objectAt becuase the position on the step is not zero based but the steps array on the chapter is
    //   var next_step = chapter.get('steps').objectAt(step.get('position'));
    //   if (!next_step) {
    //     console.log('next_step not found (eg, get the next chapters step)');
    //     console.log(chapter.get('position'));
    //     var next_chapter = this.store.all('chapter').objectAt(chapter.get('position'));
    //     if (next_chapter.get('available')) {
    //       chapter = next_chapter;
    //       next_step = next_chapter.get('steps.firstObject');
    //     } else {
    //       console.log('next chapter unavailable');
    //     }
    //
    //   }
    //
    //   this.send('select', chapter, next_step);
    // },
    //
    // select: function(chapter, step) {
    //
    //   if (this.checkStep(chapter, step)) {
    //     console.log(step.get('page.id'));
    //     console.log(step.get('page.type'));
    //     this.transitionToRoute('pages.index', step.get('page.type').dasherize(), step.get('page.id'));
    //   } else {
    //     console.log('check failed?');
    //   }
    //
    //   if (!chapter.get('selected')) {
    //     this.send('toggle', chapter);
    //   }
    // }
  },

  // checkStep: function(chapter, step) {
  //   var procceed = false,
  //       progression = step.get('progression');
  //
  //   if (this.get('isSuperUser')) { return true; };
  //
  //   if (chapter.get('available')) {
  //     console.log('chapter available');
  //
  //     if (step.get('available')) {
  //       console.log('step available');
  //       procceed = true;
  //     } else {
  //       console.log('step unavailable');
  //
  //       var previous_step = chapter.get('steps').objectAt(step.get('position') - 2)
  //       if (previous_step) {
  //         console.log('previous_step found');
  //
  //         if (previous_step.get('completed')) {
  //             console.log('previous step completed');
  //             procceed = true;
  //         } else {
  //             console.log('previous step not completed');
  //         }
  //
  //       } else {
  //         console.log('previous_step not found');
  //       }
  //
  //     }
  //
  //   } else {
  //     console.log('chapter unavailable');
  //
  //     var previous_chapter = this.store.all('chapter').objectAt(chapter.get('position') - 2);
  //     if (previous_chapter) {
  //       console.log('previous_chapter found');
  //
  //       if (previous_chapter.get('completed')) {
  //           console.log('previous chapter completed');
  //           procceed = true;
  //       } else {
  //           console.log('previous chapter not completed');
  //       }
  //
  //     } else {
  //       console.log('previous_chapter not found');
  //     }
  //
  //   }
  //
  //   // Only if we're allowed to proceed,
  //   if (procceed && progression.get('amount') >= 0.5) {
  //     progression.set('amount', 0.5);
  //   }
  //
  //   // only save the progression when its changed
  //   if (progression.get('isDirty')) {
  //     progression.save();
  //   }
  //
  //   return procceed;
  // },

  visibleChapters:function(){
    return this.get('arrangedContent').filter(function(chapter, index, self) {
      if (this.get('isComplete')) {
        return (chapter.get('visibleSteps.length') !== 0);
      } else {
        return (chapter.get('visibleSteps.length') !== 0 && !chapter.get('hidden'));
      }
    }.bind(this));
  }.property('arrangedContent.@each.visibleSteps.length', 'isSuperUser'),

  // completeStep: function(step) {
  //   var progression = step.get('progression');
  //   progression.set('amount', 1);
  //
  //   // only save the progression when its changed
  //   if (progression.get('isDirty')) {
  //     progression.save();
  //   }
  // },

  updateProgression: function(progression, amount) {
    if (progression.get('amount') > amount) { return; }
    progression.set('amount', amount);
    if (progression.get('isDirty')) {
      progression.save();
    }
  }


});
