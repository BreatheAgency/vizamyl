Course.Page = DS.Model.extend({
  type: DS.attr('string', { defaultValue: false }),
  chapter: DS.belongsTo('chapter'),
  progression: DS.belongsTo('progression'),
  position: DS.attr('number'),
  title: DS.attr('string'),
  // template_name: DS.attr('string'),
  // controller_name: DS.attr('string'),
  // page_actions: DS.attr('array'),

  available: function() {
    return this.get('progression').get('amount') !== 0;
  }.property('progression.amount'),

  completed: function() {
    return this.get('progression').get('amount') == 1;
  }.property('progression.amount'),

  progressClass: function(){
    switch(this.get('progression').get('amount')) {
      case 1:
        return 'fa-circle';
      case 0.5:
        return 'fa-dot-circle-o';
      default:
        return 'fa-circle-o';
    }
  }.property('progression.amount'),

  // actions: function(){
  //   var actions = [];
  //   this.get('page_actions').map(function(item, index, enumerable) {
  //     actions.push({
  //       title: item.title,
  //       chapter: Course.Page.store.find('chapter', item.chapter_id),
  //       page: Course.Page.store.find(item.page_type, item.page_id)
  //     });
  //   });
  //   return actions;
  // }.property('page_actions.[]')
});

Course.Video = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Video'} ),
  hello: DS.attr('string'),
  example:function(){
    return 'video'
  }.property()
});

Course.Image = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Image'} ),
  example:function(){
    return 'image'
  }.property()
});



// Course.VideoPage = Course.Page.extend({
//   type: DS.attr('string', {defaultValue: 'video_page'}),
// });
//
// Course.ImagePage = Course.Page.extend({
//   type: DS.attr('string', {defaultValue: 'image_page'}),
// });
//
// Course.ImageQuestionPage = Course.Page.extend({
//   type: DS.attr('string', {defaultValue: 'question_page'}),
//   body: DS.attr('string'),
//   questions: DS.attr('array'),
//
//   questionsWithLinks: function(){
//     var questionSets = [];
//     this.get('questions').map(function(item, index, enumerable) {
//       var questions = [];
//       item.map(function(item, index, enumerable) {
//         questions.push({
//           correct: item.correct,
//           label: item.label,
//           chapter: Course.Page.store.find('chapter', item.chapter_id),
//           page: Course.Page.store.find(item.page_type, item.page_id)
//         });
//       });
//       questionSets.push(questions);
//     });
//     return questionSets;
//   }.property('questions.[]')
// });
//
// Course.VideoPage.reopenClass({
//   FIXTURES: [
//     {
//       id: 1,
//       chapter: 1,
//       position: 1,
//       progress: 0.5,
//       title: 'Introduction Video',
//       type: 'video-page',
//       template_name: 'video_page',
//       controller_name: 'video_page',
//       page_actions: [
//         {
//           title: 'Next',
//           chapter_id: 1,
//           page_id: 2,
//           page_type: 'image_page'
//         }
//       ]
//     },
//     {
//       id: 3,
//       chapter: 2,
//       position: 3,
//       progress: 0,
//       title: 'Introduction Video',
//       type: 'video-page',
//       template_name: 'video_page',
//       controller_name: 'video_page',
//       page_actions: [
//         {
//           title: 'Next Video',
//           chapter_id: 2,
//           page_id: 4,
//           page_type: 'video_page'
//         },
//         {
//           title: 'Next Question',
//           chapter_id: 2,
//           page_id: 5,
//           page_type: 'image_question_page'
//         }
//       ]
//     },
//     {
//       id: 4,
//       chapter: 2,
//       position: 4,
//       progress: 0,
//       title: 'MRI Video',
//       type: 'video-page',
//       template_name: 'video_page',
//       controller_name: 'video_page',
//       page_actions: [
//         {
//           title: 'Next',
//           chapter_id: 2,
//           page_id: 5,
//           page_type: 'image_question_page'
//         }
//       ]
//     },
//     {
//       id: 6,
//       chapter: 2,
//       position: 6,
//       progress: 0,
//       title: 'MRI Video',
//       type: 'video-page',
//       template_name: 'video_page',
//       controller_name: 'video_page',
//       page_actions: [
//         {
//           title: 'Next',
//           chapter_id: 2,
//           page_id: 7,
//           page_type: 'image_question_page'
//         }
//       ]
//     },
//   ]
// });
//
// Course.ImagePage.reopenClass({
//   FIXTURES: [
//     {
//       id: 2,
//       chapter: 1,
//       position: 2,
//       progress: 0,
//       title: 'Learning Objectives And Instructions',
//       type: 'image-page',
//       template_name: 'image_page',
//       controller_name: 'image_page',
//       page_actions: [
//         {
//           title: 'Next',
//           chapter_id: 2,
//           page_id: 3,
//           page_type: 'video_page'
//         }
//       ]
//     }
//   ]
// });
//
// Course.ImageQuestionPage.reopenClass({
//   FIXTURES: [
//     {
//       id: 5,
//       chapter: 2,
//       position: 5,
//       progress: 0,
//       title: 'Image Question',
//       type: 'image-question-page',
//       template_name: 'image_question_page',
//       controller_name: 'image_question_page',
//       page_actions: [],
//       body: 'Rum simpers perrorum imendiciis del ipsam sunt il inturibus<br>ex et officat quatempore consequi It, aut haritibus expercipiet<br>volendam quas reicate mquae.',
//       questions: [[
//         {
//           correct: true,
//           label: 'Set A: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 6,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set A: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 4,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set A: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 4,
//           page_type: 'video_page'
//         }
//       ],[
//         {
//           correct: true,
//           label: 'Set B: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 6,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set B: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 4,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set B: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 4,
//           page_type: 'video_page'
//         }
//       ],[
//         {
//           correct: true,
//           label: 'Set C: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 6,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set C: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 4,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set C: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 4,
//           page_type: 'video_page'
//         }
//       ]]
//     },
//     {
//       id: 7,
//       chapter: 2,
//       position: 7,
//       progress: 0,
//       title: 'Image Question',
//       type: 'image-question-page',
//       template_name: 'image_question_page',
//       controller_name: 'image_question_page',
//       page_actions: [],
//       body: 'Rum simpers perrorum imendiciis del ipsam sunt il inturibus<br>ex et officat quatempore consequi It, aut haritibus expercipiet<br>volendam quas reicate mquae.',
//       questions: [[
//         {
//           correct: true,
//           label: 'Set A: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 1,
//           page_id: 1,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set A: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 6,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set A: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 6,
//           page_type: 'video_page'
//         }
//       ],[
//         {
//           correct: true,
//           label: 'Set B: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 1,
//           page_id: 1,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set B: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 6,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set B: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 6,
//           page_type: 'video_page'
//         }
//       ],[
//         {
//           correct: true,
//           label: 'Set C: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 1,
//           page_id: 1,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set C: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 6,
//           page_type: 'video_page'
//         },
//         {
//           correct: false,
//           label: 'Set C: This answer has 4 parts<br>1. Eggs<br>2. Juice<br>3. Salmon<br>4. Kale',
//           chapter_id: 2,
//           page_id: 6,
//           page_type: 'video_page'
//         }
//       ]]
//     }
//   ]
// });
