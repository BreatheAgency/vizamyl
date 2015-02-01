Course.Page = DS.Model.extend({
  page_id: DS.attr('string'),
  title: DS.attr('string'),
  subject_area: DS.attr('string'),
  template_name: DS.attr('string'),
  controller_name: DS.attr('string'),
  chapter: DS.belongsTo('chapter', { async: true }),
  step: DS.belongsTo('step'),
  progression: DS.belongsTo('progression'),

  progress: function(){
    this.get('progression').get('amount')
  }.property('progression.amount'),

  available: function() {
    return this.get('progress') !== 0;
  }.property('progress'),

  completed: function() {
    return this.get('progress') === 1;
  }.property('progress'),
});
