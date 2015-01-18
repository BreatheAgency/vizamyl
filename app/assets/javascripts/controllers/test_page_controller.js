Course.TestPageController = Ember.ObjectController.extend(Em.FSM.Stateful, {
  needs: ['application', 'localeMenu'],
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  complete: false,
  answered: Ember.computed.alias('selectedAnswer'),
  unansweredQuestionRoundIndices: Ember.A(),
  answeredQuestions: Ember.computed.filterBy('questions', 'answered', true),

  fsmStates: {
    initialState: 'unanswered',
    knownStates: ['failed', 'incorrect', 'correct'],
    unanswered: {
      didEnter: function() {

        if (this.get('unansweredQuestionRoundIndices').length === 0) {
          this.set('unansweredQuestionRoundIndices', _.shuffle(_.range(this.get('question_rounds.length'))));
        }

        var unansweredQuestionRoundIndex = this.get('unansweredQuestionRoundIndices').popObject();
        this.set('unansweredQuestionRoundIndex', unansweredQuestionRoundIndex);

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
    this.sendStateEvent('reset');
  }.observes('model'),

  questions: function() {
    return this.get('question_rounds').objectAt(this.get('unansweredQuestionRoundIndex')).get('questions');
  }.property('question_rounds.[]', 'unansweredQuestionRoundIndex'),

  unansweredQuestions: function() {
    return _.shuffle(this.get('questions').filterBy('answered', false));
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
  }.property('questions.length'),

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
    next: function(step) {
      this.get('controllers.localeMenu').send('next', step);
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
