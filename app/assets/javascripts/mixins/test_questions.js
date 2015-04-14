Course.TestQuestions = Ember.Mixin.create({
  questionSetOneSelection: null,
  questionSetTwoSelection: null,
  questionSetThreeSelection: null,
  questionSetFourSelection: null,
  questionSetFiveSelection: null,

  questionSetOne: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.negative')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.positive')})]
  }.property(),

  questionSetTwo: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.negative')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.positive')})]
  }.property(),

  questionSetThree: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.negative')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.positive')})]
  }.property(),

  questionSetFour: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.negative')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.positive')})]
  }.property(),

  questionSetFive: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.negative')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.positive')})]
  }.property()
});
