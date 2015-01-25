Course.FourBPageController = Ember.ObjectController.extend(Em.FSM.Stateful, {
  needs: ['application', 'localeMenu'],
  locale: Ember.computed.alias('controllers.application.currentLocale'),
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  complete: false,
  selectedAnswer: null,
  selectedExplanationSource: null,
  answered: Ember.computed.alias('selectedAnswer'),
  unansweredQuestionRoundIndices: Ember.A(),
  unansweredQuestions: Ember.computed.filterBy('questions', 'answered', false),
  answeredQuestions: Ember.computed.filterBy('questions', 'answered', true),
  questionSetOne: [
    Ember.Object.create({correct: true, body: 'Positive'}),
    Ember.Object.create({correct: true, body: 'Negative'}),
  ],
  questionSetOneSelection: null,
  questionSetTwo: [
    Ember.Object.create({correct: true, body: 'Positive'}),
    Ember.Object.create({correct: true, body: 'Negative'}),
  ],
  questionSetTwoSelection: null,
  questionSetThree: [
    Ember.Object.create({correct: true, body: 'Positive'}),
    Ember.Object.create({correct: true, body: 'Negative'}),
  ],
  questionSetThreeSelection: null,
  questionSetFour: [
    Ember.Object.create({correct: true, body: 'Positive'}),
    Ember.Object.create({correct: true, body: 'Negative'}),
  ],
  questionSetFourSelection: null,
  questionSetFive: [
    Ember.Object.create({correct: true, body: 'Positive'}),
    Ember.Object.create({correct: true, body: 'Negative'}),
  ],
  questionSetFiveSelection: null,

  fsmStates: {
    initialState: 'unanswered',
    knownStates: ['failed', 'answered'],
    unanswered: {
      didEnter: function() {
        console.log('unanswered didEnter');

        this.get('questions').forEach(function(question) {
          question.setProperties({
            answered: false,
            active: false,
            correct: false
          });
        });

        this.setProperties({
          selectedAnswer: null
        });
      }
    },
    answered: {
      didEnter: function() {
        console.log('correct didEnter');
        this.setProperties({
          complete: true
        });
      }
    }
  },

  fsmEvents: {
    answer: {
      transitions: [
        { unanswered: 'answered' },
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
    console.log('modelDidChange');
    if (this.get('unansweredQuestionRoundIndices.length') === 0) {
      this.set('unansweredQuestionRoundIndices', _.shuffle(_.range(this.get('question_rounds.length'))));
    }
    this.set('unansweredQuestionRoundIndex', this.get('unansweredQuestionRoundIndices').popObject());
    this.sendStateEvent('reset');
  }.observes('model'),

  questions: function() {
    return this.get('question_rounds').objectAt(this.get('unansweredQuestionRoundIndex')).get('questions');
  }.property('question_rounds.[]', 'unansweredQuestionRoundIndex'),

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
  }.property('questions.length'),

  explanationSource:function(){
    var source = this.get('selectedExplanationSource')
    if (source == null){
      return this.get('answeredQuestions.firstObject.explanation_source');
    } else {
      return source;
    }
  }.property('selectedExplanationSource'),

  testComplete: function() {
    return this.get('questions.length') == this.get('answeredQuestions.length')
  }.property('questions.[]', 'answeredQuestions'),

  testCorrect: function() {
    var correct_questions_length = this.get('answeredQuestions').filterBy('correct', true).get('length');
    // The user must get at least 14 questions right
    return (correct_questions_length >= 1);
  }.property('answeredQuestions'),

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

  actions: {
    selectExplanation: function(explanation_source){
      this.set('selectedExplanationSource', explanation_source);
    },
    next: function() {
      if(this.get('testCorrect')) {
        window.location.replace('/' + this.get('locale') + '/users/course-complete');
      } else if(this.get('unansweredQuestionRoundIndices.length') === 0) {
        window.location.replace('/' + this.get('locale') + '/users/course-incomplete');
      } else {
        this.sendStateEvent('reset');
      }
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
