Course.TestPageController = Ember.ObjectController.extend(Em.FSM.Stateful, {
  needs: ['application', 'localeMenu'],
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  complete: false,
  answeredQuestions: Ember.A(),
  unansweredQuestionIndices: Ember.A(),
  unansweredQuestionRoundIndices: Ember.A(),

  states: {
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
        this.set('complete', true);
      }
    }
  },

  stateEvents: {
    answer: {
      transitions: [
        { unanswered: 'correct', doIf: 'questionIsRight' },
        { unanswered: 'incorrect', doUnless: 'questionIsRight' }
      ]
    },
    reset: {
      transitions: {
        from: '$all',
        to: 'unanswered'
      }
    }
  },

  pageDidChange: function() {
    this.setProperties({
      answeredQuestions: Ember.A(),
      unansweredQuestionIndices: Ember.A(),
      unansweredQuestionRoundIndices: Ember.A()
    });
    this.sendStateEvent('reset');
  }.observes('page'),

  unansweredQuestionRoundIndex: function() {
    if (this.get('unansweredQuestionRoundIndices').length === 0) {
      this.set('unansweredQuestionRoundIndices', _.shuffle(_.range(this.get('question_rounds.length'))));
    }
    return this.get('unansweredQuestionRoundIndices').pop();
  }.property('question_rounds.[]').volatile(),

  questions: function() {
    return this.get('question_rounds').objectAt(this.get('unansweredQuestionRoundIndex')).get('questions');
  }.property('question_rounds.[]', 'unansweredQuestionRoundIndex'),

  unansweredQuestionIndex: function() {
    if (this.get('unansweredQuestionIndices').length === 0) {
      this.set('unansweredQuestionIndices', _.shuffle(_.range(this.get('questions.length'))));
    }
    return this.get('unansweredQuestionIndices').pop();
  }.property('questions.[]').volatile(),

  question: function() {
    return this.get('questions').objectAt(this.get('unansweredQuestionIndex'));
  }.property('questions.[]', 'unansweredQuestionIndex'),

  questionIsRight: function() {
    return (this.target.get('selectedAnswer') && this.target.get('selectedAnswer.correct'));
  },

  actions: {
    next: function() {
      this.get('controllers.localeMenu').send('next', chapter, step);
      this.sendStateEvent('reset');
    },
    submit: function() {
      this.get('question').set('answered', true);
      // this.answeredQuestions.push(this.get('unansweredQuestionIndex'));
      // this.sendStateEvent('answer');
    },
  }
});
//
// Course.TestPageController = Ember.ObjectController.extend({
//   needs: ['application', 'localeMenu'],
//   isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
//   complete: true,
//   actions: {
//     next:function(chapter, step) {
//       this.get('controllers.localeMenu').send('next', chapter, step);
//     },
//   }
// });
