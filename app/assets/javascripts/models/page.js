Course.Page = Ember.Mixin.create({
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

Course.Video = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Video' } ),
  mandatory: DS.attr('boolean', {defaultValue: true }),
  source: DS.attr('string'),
  body: DS.attr('string'),
  references: DS.attr('string'),

  style: function() {
    if (this.get('mandatory')) {
      return 'border: solid 1px #00FFFF';
    } else {
      return 'border: solid 1px #FF0000';
    }
  }.property('mandatory')
});

Course.Image = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Image' } ),
  style: 'border: solid 1px #1CC444;',
  source: DS.attr('string')
});

Course.Text = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Text' } ),
  style: 'border: solid 1px #1CC444;',
  body: DS.attr('string'),
});

Course.Interactive = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'Interactive' } ),
  style: 'border: solid 1px #FFFF00;',
  body: DS.attr('string'),
});

Course.QuestionIntro = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'QuestionIntro' } ),
  style: 'border: solid 1px #FF9900;',
  body: DS.attr('string'),
});

Course.InteractiveQuestion = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'InteractiveQuestion' } ),
  style: 'border: solid 1px #EE96C4;',
});

Course.ImageQuestion = DS.Model.extend(Course.Page, {
  type: DS.attr('string', { defaultValue: 'ImageQuestion' } ),
  style: 'border: solid 1px #980000;',
});
