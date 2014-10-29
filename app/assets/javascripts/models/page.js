Course.Page = DS.Model.extend({
  type: DS.attr('string', { defaultValue: false }),
  title: DS.attr('string'),
  subject_area: DS.attr('string'),
  template_name: DS.attr('string'),
  controller_name: DS.attr('string'),
  chapter: DS.belongsTo('chapter'),
  progression: DS.belongsTo('progression'),

  progress: function(){
    this.get('progression').get('amount')
  }.property('progression.amount'),

  available: function() {
    return this.get('progress') !== 0;
  }.property('progress'),

  completed: function() {
    return this.get('progression') === 1;
  }.property('progress'),
});

Course.Video = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Video' } ),
  mandatory: DS.attr('boolean', {defaultValue: true }),

  style: function() {
    if (this.get('mandatory')) {
      return 'border: solid 1px #00FFFF';
    } else {
      return 'border: solid 1px #FF0000';
    }
  }.property('mandatory')
});

Course.Image = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Image' } ),
  style: 'border: solid 1px #1CC444;',
});

Course.Text = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Text' } ),
  style: 'border: solid 1px #1CC444;',
});

Course.Interactive = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'Interactive' } ),
  style: 'border: solid 1px #FFFF00;',
});

Course.QuestionIntro = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'QuestionIntro' } ),
  style: 'border: solid 1px #FF9900;',
});

Course.InteractiveQuestion = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'InteractiveQuestion' } ),
  style: 'border: solid 1px #EE96C4;',
});

Course.ImageQuestion = Course.Page.extend({
  type: DS.attr('string', { defaultValue: 'ImageQuestion' } ),
  style: 'border: solid 1px #980000;',
});
