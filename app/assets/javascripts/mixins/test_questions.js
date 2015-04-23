Course.TestQuestions = Ember.Mixin.create({
  questionSetOneSelection: null,
  questionSetTwoSelection: null,
  questionSetThreeSelection: null,
  questionSetFourSelection: null,
  questionSetFiveSelection: null,

  questionsWithIndex: function() {
    var index = 1;
    var question = Ember.Object.extend({
      object: null,
      index: null,
      incorrect_title: null,
      correct_title: null,
      correct_title_int: function () {
        return Ember.String.interpolate(this.get('correct_title'), this);
      }.property('correct_title'),
      incorrect_title_int: function () {
        return Ember.String.interpolate(this.get('incorrect_title'), this);
      }.property('incorrect_title')
    });
    return this.get('questions').map(function(item) {
      return question.create({
        object: item,
        index: index,
        correct_title: item.get('correct_title'),
        incorrect_title: item.get('incorrect_title')
      })
    })
  }.property('questions.[]'),

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
