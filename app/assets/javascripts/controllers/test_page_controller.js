Course.TestPageController = Ember.ObjectController.extend(Em.FSM.Stateful, {
  needs: ['application', 'localeMenu'],
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  complete: false,
  answered: Ember.computed.alias('selectedAnswer'),
  unansweredQuestionRoundIndices: Ember.A(),

  fsmStates: {
    initialState: 'unanswered',
    knownStates: ['failed', 'incorrect', 'correct'],
    unanswered: {
      didEnter: function() {
        this.setProperties({
          selectedAnswer: null
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
    this.setProperties({
      unansweredQuestionRoundIndices: Ember.A()
    });
    this.get('questions').forEach(function(question) {
      question.setProperties({
        answered: false,
        active: false,
        correct: false
      });
    });
    this.sendStateEvent('reset');
  }.observes('model'),

  unansweredQuestionRoundIndex: function() {
    if (this.get('unansweredQuestionRoundIndices').length === 0) {
      this.set('unansweredQuestionRoundIndices', _.shuffle(_.range(this.get('question_rounds.length'))));
    }
    return this.get('unansweredQuestionRoundIndices').pop();
  }.property('question_rounds.[]').volatile(),

  questions: function() {
    return this.get('question_rounds').objectAt(this.get('unansweredQuestionRoundIndex')).get('questions');
  }.property('question_rounds.[]', 'unansweredQuestionRoundIndex'),

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
    return this.get('questions.length') == this.get('answeredQuestions.length')
  }.property('questions.[]', 'answeredQuestions'),

  testCorrect: function() {
    return !this.get('answeredQuestions').isAny('correct', false);
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
    next:function(chapter, step) {
      this.get('controllers.localeMenu').send('next', chapter, step);
      this.sendStateEvent('reset');
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
