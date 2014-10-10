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
      return 'border: solid 1px Crimson';
    } else {
      return 'border: solid 1px LightSkyBlue';
    }
  }.property('mandatory')
});

Course.Image = Course.Step.extend({
  style: 'border: solid 1px Blue;',
  type: DS.attr('string', { defaultValue: 'Image' } )
});

Course.Text = Course.Step.extend({
  style: 'border: solid 1px Green;',
  type: DS.attr('string', { defaultValue: 'Text' } )
});

Course.Interactive = Course.Step.extend({
  style: 'border: solid 1px AliceBlue;',
  type: DS.attr('string', { defaultValue: 'Interactive' } )
});

// InteractiveQuestion HotPink
// ImageQuestion Maroon
Course.Question = Course.Step.extend({
  type: DS.attr('string', { defaultValue: 'Question' } )
});
