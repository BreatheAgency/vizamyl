Course.LocaleMenuController = Ember.ArrayController.extend({
  needs: ['application'],
  sortProperties: ['position'],
  sortAscending: true,
  isComplete: Ember.computed.alias('controllers.application.isComplete'),
  hiddenChapters: Ember.computed.filterBy('arrangedContent', 'hidden', true),
  isEuropean: Ember.computed.alias('controllers.application.isEuropean'),
  hasItalianOrigin: Ember.computed.alias('controllers.application.hasItalianOrigin'),
  currentLocale: Ember.computed.alias('controllers.application.currentLocale'),

  useVideoLink: function () {
    return '/' + this.get('currentLocale') + "/users/use";
  }.property('currentLocale'),

  videoLinkText: function () {
    var locale = this.get('currentLocale');
    switch(locale) {
    case 'fr':
      return 'Utilisation complémentaire de la quantification';
    case 'es':
      return 'Uso complementario de la cuantificación';
    case 'it':
      return 'Modulo supplementare sulla quantificazione';
    case 'de':
      return 'Zusatzmodul Quantifizierung';
    case 'de-at':
      return 'Zusatzmodul Quantifizierung';
    default:
      return "Adjunctive Use of Quantification";
    }
  }.property('currentLocale'),

  actions: {
    toggle: function(chapter){
      if (!chapter.get('available')) { return; }
      var originalSelectedState = chapter.get('selected');
      this.get('model').setEach('selected', false);
      chapter.set('selected', !originalSelectedState);
    },

    selectStep: function(step) {
      // check the step's availabilty
      if (!step.get('available')) { return; }

      var page_id = step.get('page.id');
      var page_type = step.get('page.type');

      if (page_id == undefined) { page_id = step._data.page.id; }
      if (page_type == undefined) { page_type = step._data.page.type; }

      // go to the step's page
      this.transitionToRoute('pages.index', Ember.String.dasherize(page_type), page_id);

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
  },

  updateProgression: function(progression, amount) {
    if (progression.get('amount') > amount) { return; }
    progression.set('amount', amount);
    if (progression.get('isDirty')) {
      progression.save();
    }
  },

  visibleChapters:function(){
    return this.get('arrangedContent').filter(function(chapter, index, self) {
      return (chapter.get('visibleSteps.length') !== 0 && !chapter.get('hidden'));
    });
  }.property('arrangedContent.@each.hidden', 'arrangedContent.@each.visibleSteps.length')

});
