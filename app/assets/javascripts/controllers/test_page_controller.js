Course.TestPageController = Ember.ObjectController.extend(Course.TestQuestions, Em.FSM.Stateful, {
  needs: ['application', 'localeMenu'],
  complete: false,
  currentPage: Ember.computed.alias('controllers.application.currentPage'),
  selectedAnswer: null,
  answered: Ember.computed.bool('selectedAnswer'),
  unansweredQuestionRoundIndices: Ember.A(),
  singleQuestion: Ember.computed.equal('questions.length', 1),

  fsmStates: {
    initialState: 'unanswered',
    knownStates: ['expanded', 'failed', 'incorrect', 'correct'],
    unanswered: {
      didEnter: function() {
        if (this.get('unansweredQuestionRoundIndices.length') === 0) {
          this.set('unansweredQuestionRoundIndices', _.shuffle(_.range(this.get('question_rounds.length'))));
        }

        this.set('unansweredQuestionRoundIndex', this.get('unansweredQuestionRoundIndices').popObject());

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
        to: 'unanswered'
      }
    }
  },

  modelDidChange: function() {
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
    switch(this.get('question.interactive_sources.length')) {
      case 1:
        return 521;
        break;
      case 2:
        return 230
        break;
      default:
        return 163;
    }
  }.property('question.interactive_sources.[]'),

  actions: {
    next: function(step) {
      this.get('controllers.localeMenu').send('nextStep', step);
      this.sendStateEvent('reset');
    },
    failure: function() {
      this.store.find('step', this.get('failure_step_id')).then(function (step) {
        this.get('controllers.localeMenu').send('selectStep', step);
        this.sendStateEvent('reset');
      }.bind(this));
    },
    submit: function() {
      if (!this.get('answered')) { return; }

      this.get('question').setProperties({
        answered: true,
        active: false,
        timeAnswered: Date.now(),
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
