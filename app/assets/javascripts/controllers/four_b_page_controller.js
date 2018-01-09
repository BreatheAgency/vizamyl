Course.FourBPageController = Ember.ObjectController.extend(Course.TestQuestions, Em.FSM.Stateful, {
  needs: ['application', 'localeMenu'],
  complete: false,
  currentLocale: Ember.computed.alias('controllers.application.currentLocale'),
  currentChapter: Ember.computed.alias('controllers.application.currentChapter'),
  selectedAnswer: null,
  selectedExplanationSource: null,
  answered: Ember.computed.alias('selectedAnswer'),
  unansweredQuestionRoundIndices: Ember.A(),

  fsmStates: {
    initialState: 'unanswered',
    knownStates: ['expanded', 'failed', 'answered'],
    answered: {
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
        { unanswered: 'answered' },
      ]
    },
    expand: {
      transitions: [
        { unanswered: 'expanded' }
      ]
    },
    contract: {
      transitions: [
        { expanded: 'unanswered' }
      ]
    },
    reset: {
      transitions: {
        from: '$all',
        didEnter: 'unansweredEnter',
        to: 'unanswered'
      }
    }
  },

  unansweredEnter: function() {
    this.set('unansweredQuestionRoundIndex', this.get('unansweredQuestionRoundIndices').shiftObject());

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
  },

  modelDidChange: function() {
    this.set('unansweredQuestionRoundIndices', _.range(this.get('question_rounds.length')));
    this.sendStateEvent('reset');
  }.observes('model'),

  questions: function() {
    return this.get('question_rounds').objectAt(this.get('unansweredQuestionRoundIndex')).get('questions');
  }.property('question_rounds.[]', 'unansweredQuestionRoundIndex'),

  unansweredQuestions: function() {
    return this.get('questions').filterBy('answered', false);
  }.property('questions.@each.answered'),

  answeredQuestions: function() {
    return this.get('questions').filterBy('answered', true);
  }.property('questions.@each.answered'),

  question: function() {
    var q = this.get('unansweredQuestions.firstObject');
    if (q) { q.set('active', true); }
    return q;
  }.property('unansweredQuestions'),

  explanationSource:function(){
    var source = this.get('selectedExplanationSource')
    if (source == null){
      return this.get('answeredQuestions.firstObject.explanation_source');
    } else {
      return source;
    }
  }.property('selectedExplanationSource'),

  testComplete: function() {
    return this.get('questions.length') == this.get('answeredQuestions.length');
  }.property('questions.[]', 'answeredQuestions'),

  testCorrect: function() {
    var correct_questions_length = this.get('answeredQuestions').filterBy('correct', true).get('length');
    return (correct_questions_length >= 14);
  }.property('answeredQuestions'),

  testFailedOnce: function() {
    return (this.get('unansweredQuestionRoundIndex') === 0);
  }.property('unansweredQuestionRoundIndex'),

  testFailedTwice: function() {
    return !this.get('testCorrect') && !this.get('testFailedOnce');
  }.property('testCorrect', 'testFailedOnce'),

  // Japanese don't provide an in-person training course
  shouldHaveInfiniteRetries: function() {
    return this.get('currentLocale') == 'jp';
  }.property('currentLocale'),

  showRetakeButton: function() {
    return this.get('shouldHaveInfiniteRetries') && this.get('isInAnswered') && !this.get('testCorrect');
  }.property('shouldHaveInfiniteRetries', 'isInAnswered', 'testCorrect'),

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
    selectExplanation: function(explanation_source){
      this.set('selectedExplanationSource', explanation_source);
    },
    next: function() {
      if(this.get('testCorrect')) {
        window.location.replace('/' + this.get('currentLocale') + '/users/course-complete');
      } else {
        this.sendStateEvent('reset');
      }
    },
    retakeTest: function(){
      // Don't go on to question round two, as anyone seeing the `retake` button
      // should have infinite retries. Instead, we take them back to the first step of
      // this chapter to have another crack.
      this.set('unansweredQuestionRoundIndices', _.range(this.get('question_rounds.length')));

      first_step_id = this.get('currentChapter').get('steps').objectAt(0).id;
      this.store.find('step', first_step_id).then(function (step) {
        this.get('controllers.localeMenu').send('selectStep', step);
        this.sendStateEvent('reset');
      }.bind(this));
    },
    submit: function() {
      if (!this.get('answered')) { return; }

      this.get('question').setProperties({
        answered: true,
        active: false,
        correct: this.get('selectedAnswer.correct')
      });

      this.setProperties({
        selectedAnswer: null,
        questionSetOneSelection: null,
        questionSetTwoSelection: null,
        questionSetThreeSelection: null,
        questionSetFourSelection: null,
        questionSetFiveSelection: null,
      });

      if (this.get('testComplete')) {
        this.sendStateEvent('answer');
      }
    },
    expand: function() {
      this.sendStateEvent('expand');
    },
    contract: function() {
      this.sendStateEvent('contract');
    }
  }
});
