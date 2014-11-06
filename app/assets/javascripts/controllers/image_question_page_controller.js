// Course.ImageQuestionPageController = Ember.ObjectController.extend(Em.FSM.Stateful, {
//   needs: ['localeMenu'],
//   answeredQuestionSets: Ember.A(),
//   unansweredQuestionSetIndices: Ember.A(),
//
//   states: {
//     initialState: 'unanswered',
//     knownStates: ['failed', 'incorrect', 'correct'],
//     unanswered: {
//       didEnter: function() {
//         this.setProperties({
//           selectedQuestion: null
//         });
//       }
//     }
//   },
//
//   stateEvents: {
//     answer: {
//       transitions: [
//         { unanswered: 'correct', doIf: 'questionIsRight' },
//         { unanswered: 'incorrect', doUnless: 'questionIsRight' }
//       ]
//     },
//     reset: {
//       transitions: {
//         from: '$all',
//         to: 'unanswered'
//       }
//     }
//   },
//
//   pageDidChange: function() {
//     this.setProperties({
//       answeredQuestionSets: Ember.A(),
//       unansweredQuestionSetIndices: Ember.A()
//     });
//     this.sendStateEvent('reset');
//   }.observes('page'),
//
//   unansweredQuestionSetIndex: function() {
//     if (this.get('unansweredQuestionSetIndices').length === 0) {
//       this.set('unansweredQuestionSetIndices', _.shuffle(_.range(this.get('questions').get('length'))));
//     }
//     return this.get('unansweredQuestionSetIndices').pop();
//   }.property('questionsWithLinks.[]').volatile(),
//
//   questionSet: function() {
//     return this.get('questionsWithLinks')[this.get('unansweredQuestionSetIndex')];
//   }.property('questionsWithLinks.[]', 'unansweredQuestionSetIndex'),
//
//   questionIsRight: function() {
//     return (this.target.get('selectedQuestion') && this.target.get('selectedQuestion').correct);
//   },
//
//   actions: {
//     next: function() {
//       this.get('controllers.localeMenu').send('select', this.get('selectedQuestion').chapter, this.get('selectedQuestion').page);
//       this.sendStateEvent('reset');
//     },
//     submit: function() {
//       this.answeredQuestionSets.push(this.get('unansweredQuestionSetIndex'));
//       this.sendStateEvent('answer');
//     },
//   }
// });

Course.ImageQuestionPageController = Ember.ObjectController.extend({
  needs: ['application', 'localeMenu'],
  isSuperUser: Ember.computed.alias('controllers.application.isSuperUser'),
  complete: true,
  actions: {
    next:function(chapter, step) {
      this.get('controllers.localeMenu').send('next', chapter, step);
    },
  }
});
