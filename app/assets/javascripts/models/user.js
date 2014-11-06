Course.User = DS.Model.extend({
  email: DS.attr('string'),
  super_user: DS.attr('boolean', {defaultValue: false }),
  locale: DS.attr('string'),
  progressions: DS.hasMany('progression'),

  // latest_step:function(){
    // return this.get('progressions').filter(function(item, index, enumerable){
    //   return item.amount == 0.5 || 1
    // }).get('lastObject');
    // return _.last(this.get('progressions'));
  // }.property('progressions.@each.amount')
});
