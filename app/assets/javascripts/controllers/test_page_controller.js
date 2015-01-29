Course.TestPageController = Ember.ObjectController.extend(Em.FSM.Stateful, {
  needs: ['application', 'localeMenu'],
  currentPage: Ember.computed.alias('controllers.application.currentPage'),
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  complete: false,
  selectedAnswer: null,
  answered: Ember.computed.bool('selectedAnswer'),
  unansweredQuestionRoundIndices: Ember.A(),
  questionSetOne: [
    Ember.Object.create({correct: true, body: 'Negative'}),
    Ember.Object.create({correct: true, body: 'Positive'}),
  ],
  questionSetOneSelection: null,
  questionSetTwo: [
    Ember.Object.create({correct: true, body: 'Negative'}),
    Ember.Object.create({correct: true, body: 'Positive'}),
  ],
  questionSetTwoSelection: null,
  questionSetThree: [
    Ember.Object.create({correct: true, body: 'Negative'}),
    Ember.Object.create({correct: true, body: 'Positive'}),
  ],
  questionSetThreeSelection: null,
  questionSetFour: [
    Ember.Object.create({correct: true, body: 'Negative'}),
    Ember.Object.create({correct: true, body: 'Positive'}),
  ],
  questionSetFourSelection: null,
  questionSetFive: [
    Ember.Object.create({correct: true, body: 'Negative'}),
    Ember.Object.create({correct: true, body: 'Positive'}),
  ],
  questionSetFiveSelection: null,

  fsmStates: {
    initialState: 'unanswered',
    knownStates: ['failed', 'incorrect', 'correct'],
    unanswered: {
      didEnter: function() {

        this.get('questions').forEach(function(question) {
          question.setProperties({
            answered: false,
            active: false,
            correct: false
          });
        });

        this.setProperties({
          selectedAnswer: null,
          questionSetOneSelection: null,
          questionSetTwoSelection: null,
          questionSetThreeSelection: null,
          questionSetFourSelection: null,
          questionSetFiveSelection: null,
        });
      }
    },
    correct: {
      didEnter: function() {
        this.setProperties({
          complete: true
        });
      }
    }
  },

  fsmEvents: {
    answer: {
      transitions: [
        { unanswered: 'correct', doIf: 'testCorrect' },
        { unanswered: 'incorrect', doUnless: 'testCorrect' }
      ]
    },
    reset: {
      transitions: {
        from: '$all',
        to: 'unanswered'
      }
    }
  },

  modelDidChange: function() {
    if (this.get('unansweredQuestionRoundIndices.length') === 0) {
      // _.shuffle()
      this.set('unansweredQuestionRoundIndices', _.range(this.get('question_rounds.length')));
    }
    this.set('unansweredQuestionRoundIndex', this.get('unansweredQuestionRoundIndices').popObject());
    this.sendStateEvent('reset');
  }.observes('model'),

  questions: function() {
    var unansweredQuestions = this.get('question_rounds').objectAt(this.get('unansweredQuestionRoundIndex'));
    return unansweredQuestions.get('questions');
  }.property('question_rounds', 'unansweredQuestionRoundIndex'),

  unansweredQuestions: function() {
    return _.shuffle(this.get('questions').filterBy('answered', false));
  }.property('questions.@each.answered'),

  answeredQuestions: function() {
    return this.get('questions').filterBy('answered', true);
  }.property('questions.@each.answered'),

  question: function() {
    var q = this.get('unansweredQuestions.firstObject');
    if (q) { q.set('active', true); }
    return q;
  }.property('unansweredQuestions'),

  questionsWithIndex: function() {
    var index = 1;
    return this.get('questions').map(function(item) {
      return Em.Object.create({
        value: item,
        index: index++
      });
    })
  }.property('questions.[]'),

  testComplete: function() {
    return this.get('questions.length') === this.get('answeredQuestions.length')
  }.property('questions.[]', 'answeredQuestions.[]'),

  testCorrect: function() {
    return !this.get('answeredQuestions').isAny('correct', false);
  }.property('answeredQuestions.@each.correct'),

  columns: function(){
    switch(this.get('question.interactive_sources.length')) {
      case 1:
        return 'small-12 large-12';
        break;
      case 2:
        return 'small-6 large-6';
        break;
      default:
        return 'small-4 large-4';
    }
  }.property('question.interactive_sources.[]'),

  interactiveWidth: function() {
    switch(this.get('interactive_sources.length')) {
      case 1:
        return 521;
        break;
      case 2:
        return 230
        break;
      default:
        return 163;
    }
  }.property('interactive_sources.[]'),

  actions: {
    next: function(step) {
      this.get('controllers.localeMenu').send('nextStep', step);
      this.sendStateEvent('reset');
    },
    failure: function(){
      this.store.find('step', this.get('failure_step_id')).then(function (step) {
        this.get('controllers.localeMenu').send('selectStep', step);
        this.sendStateEvent('reset');
      }.bind(this));
    },
    submit: function() {
      this.get('question').setProperties({
        answered: true,
        active: false,
        correct: this.get('selectedAnswer.correct')
      });

      this.set('selectedAnswer', null);

      if (this.get('testComplete')) {
        this.sendStateEvent('answer');
      }
    },
  }
});
