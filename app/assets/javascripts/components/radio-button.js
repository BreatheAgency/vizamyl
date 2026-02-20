Course.RadioButtonComponent = Ember.Component.extend({
  tagName : 'input',
  type : 'radio',
  attributeBindings : ['name', 'type', 'value', 'checked:checked'],

  checked : function() {
    return this.get('value') === this.get('selection');
  }.property('selection'),

  click : function() {
    this.set('selection', this.get('value'));
  },
});

Ember.Handlebars.helper('radio-button', Course.RadioButtonComponent);

Course.ExtRadioComponent = Ember.Component.extend({
  name: 'radio'
});

Ember.Handlebars.helper('ext-radio-button', Course.ExtRadioComponent);
