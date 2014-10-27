Course.Step = DS.Model.extend({
  type: DS.attr('string', { defaultValue: false }),
  chapter: DS.belongsTo('chapter'),
  progression: DS.belongsTo('progression'),
  position: DS.attr('number'),
  title: DS.attr('string'),
  template_name: DS.attr('string'),
  controller_name: DS.attr('string'),
  page: DS.belongsTo('step', {polymorphic: true}),

  progress: function(){
    this.get('progression').get('amount')
  }.property('progression.amount'),

  available: function() {
    return this.get('progress') !== 0;
  }.property('progress'),

  completed: function() {
    return this.get('progression') === 1;
  }.property('progress'),

  progressClass: function(){
    switch(this.get('progress')) {
      case 1:
        return 'fi-checkbox';
      case 0.5:
        return 'fi-contrast';
      default:
        return 'fi-x-circle';
    }
  }.property('progress')
});

Course.Video = Course.Step.extend({
  type: DS.attr('string', {defaultValue: 'Video'}),
  mandatory: DS.attr('boolean', {defaultValue: false }),

  style: function() {
    if (this.get('mandatory')) {
      return 'border: solid 1px #00FFFF';
    } else {
      return 'border: solid 1px #FF0000';
    }
  }.property('mandatory')
});

Course.Image = Course.Step.extend({
  style: 'border: solid 1px #1CC444;',
  type: DS.attr('string', { defaultValue: 'Image' } )
});

Course.Text = Course.Step.extend({
  style: 'border: solid 1px #1CC444;',
  type: DS.attr('string', { defaultValue: 'Text' } )
});

Course.Interactive = Course.Step.extend({
  style: 'border: solid 1px #FFFF00;',
  type: DS.attr('string', { defaultValue: 'Interactive' } )
});

Course.QuestionIntro = Course.Step.extend({
  style: 'border: solid 1px #FF9900;',
  type: DS.attr('string', { defaultValue: 'QuestionIntro' } )
});

Course.InteractiveQuestion = Course.Step.extend({
  style: 'border: solid 1px #EE96C4;',
  type: DS.attr('string', { defaultValue: 'InteractiveQuestion' } )
});

Course.ImageQuestion = Course.Step.extend({
  style: 'border: solid 1px #980000;',
  type: DS.attr('string', { defaultValue: 'ImageQuestion' } )
});
