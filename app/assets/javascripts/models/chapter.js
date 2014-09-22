Course.Chapter = DS.Model.extend({
  position: DS.attr('number'),
  // location: DS.attr('string'),
  title: DS.attr('string'),
  // pages: DS.hasMany('page', {async: true, polymorphic: true}),
  steps: DS.hasMany('step'),
  //
  hashId: function(){
    return '#' + this.get('id');
  }.property('id'),
  //
  // progressedPages: function() {
  //   return this.get('pages').filter(function(page, index, self) {
  //     if (page.get('progress') > 0) { return true; }
  //   });
  // }.property('pages.@each.progress'),
  //
  available: function() {
    return true;
  }.property()
  // available: function() {
  //   return this.get('progressedPages').get('length') !== 0;
  // }.property('progressedPages'),
  //
  // completed: Ember.aliasMethod('available'),
  //
  // currentProgress: function() {
  //   return this.get('progressedPages').get('length');
  // }.property('progressedPages'),
  //
  // isFinished: function() {
  //   return this.get('progressedPages').get('length') === this.get('totalProgress');
  // }.property('progressedPages', 'totalProgress'),
  //
  // totalProgress: function() {
  //   return this.get('pages').get('length');
  // }.property('pages.length'),
  //
  // progress: function() {
  //   return (((this.get('progressedPages').get('length')) / this.get('totalProgress')) * 100) + '%';
  // }.property('progressedPages', 'totalProgress')

});

// Course.Chapter.reopenClass({
//   FIXTURES: [
//     {
//       id: 1,
//       position: 1,
//       location: 'introduction',
//       title: 'Introduction',
//       pages: [
//         {
//           id: 1,
//           type: 'video_page'
//         },
//         {
//           id: 2,
//           type: 'image_page'
//         }
//       ]
//     },
//     {
//       id: 2,
//       position: 2,
//       location: 'one-a',
//       title: 'Chapter 1a',
//       pages: [
//         {
//           id: 3,
//           type: 'video_page'
//         },
//         {
//           id: 4,
//           type: 'video_page'
//         },
//         {
//           id: 5,
//           type: 'image_question_page'
//         },
//         {
//           id: 6,
//           type: 'video_page'
//         },
//         {
//           id: 7,
//           type:'image_question_page'
//         }
//       ]
//     },
//     // {
//     //   id: 3,
//     //   position: 3,
//     //   location: 'one-b',
//     //   title: 'Chapter 1b',
//     //   pages: []
//     // },
//     // {
//     //   id: 4,
//     //   position: 4,
//     //   location: 'two-a',
//     //   title: 'Chapter 2a',
//     //   pages: []
//     // },
//     // {
//     //   id: 5,
//     //   position: 5,
//     //   location: 'two-b',
//     //   title: 'Chapter 2b',
//     //   pages: []
//     // },
//     // {
//     //   id: 6,
//     //   position: 6,
//     //   location: 'three-a',
//     //   title: 'Chapter 3a',
//     //   pages: []
//     // },
//     // {
//     //   id: 7,
//     //   position: 7,
//     //   location: 'three-b',
//     //   title: 'Chapter 3b',
//     //   pages: []
//     // },
//     // {
//     //   id: 8,
//     //   position: 8,
//     //   location: 'three-c',
//     //   title: 'Chapter 3c',
//     //   pages: []
//     // },
//     // {
//     //   id: 9,
//     //   position: 9,
//     //   location: 'three-d',
//     //   title: 'Chapter 3d',
//     //   pages: []
//     // },
//     // {
//     //   id: 10,
//     //   position: 10,
//     //   location: 'three-e',
//     //   title: 'Chapter 3e',
//     //   pages: []
//     // },
//     // {
//     //   id: 11,
//     //   position: 11,
//     //   location: 'three-f',
//     //   title: 'Chapter 3f',
//     //   pages: []
//     // },
//     // {
//     //   id: 12,
//     //   position: 12,
//     //   location: 'four-a',
//     //   title: 'Chapter 4a',
//     //   pages: []
//     // },
//     // {
//     //   id: 13,
//     //   position: 13,
//     //   location: 'four-b',
//     //   title: 'Chapter 4b',
//     //   pages: []
//     // }
//   ]
// });
