// Course.IntroductionController = Ember.Controller.extend(Em.FSM.Stateful, {
//   needs: ['application'],
//
//   states: {
//     initialState: 'p1',
//     knownStates: ['failed', 'p1', 'p2', 'p3', 'p4', 'p5', 'outro'],
//   },
//
//   stateEvents: {
// 
//     next: {
//       transitions: [
//         { p1: 'p2' },
//         { p2: 'p4' },
//         { p3: 'p5' },
//         { p5: 'outro'}
//       ]
//     },
//
//     nextVideo: {
//       transitions: [
//         { p1: 'p2' },
//         { p4: 'p3' }
//       ]
//     },
//
//     nextQuestion: {
//       transitions: [
//         { p1: 'p4' },
//         { p4: 'p5' }
//       ]
//     }
//   },
//
//   actions: {
//     next: function() {
//       console.log('next');
//       this.sendStateEvent('next');
//     },
//     nextVideo: function() {
//       console.log('nextVideo');
//       this.sendStateEvent('nextVideo');
//     },
//     nextQuestion: function() {
//       console.log('nextQuestion');
//       this.sendStateEvent('nextQuestion');
//     }
//   }
// });
