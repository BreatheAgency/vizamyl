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
      timeAnswered: 0,
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
        index: index++,
        timeAnswered: item.get('timeAnswered'),
        correct_title: item.get('correct_title'),
        incorrect_title: item.get('incorrect_title')
      });
    });
  }.property('questions.[]', 'questions.@each.timeAnswered'),

  questionsInOrder: function() {
    var newIndex = 1;
    var questionsWithIndex = this.get('questionsWithIndex');
    return _.sortBy(questionsWithIndex, 'timeAnswered').map(function(q) {
      q.index = newIndex++;
      return q;
    });
  }.property('questionsWithIndex'),

  questionSetOne: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_one.answer_one')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_one.answer_two')})]
  }.property(),

  questionSetTwo: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_two.answer_one')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_two.answer_two')})]
  }.property(),

  questionSetThree: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_three.answer_one')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_three.answer_two')})]
  }.property(),

  questionSetFour: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_four.answer_one')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_four.answer_two')})]
  }.property(),

  questionSetFive: function() {
    return [Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_five.answer_one')}), Ember.Object.create({correct: true, body: I18n.t('course.pages.test.question_five.answer_two')})]
  }.property()
});
