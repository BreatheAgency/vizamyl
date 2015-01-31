Ember.Application.initializer({
  name: 'env',
  initialize: function(container, application) {
    // 0. Check to see that we have a bucket for the env data
    if(application.get('env') === undefined) {
      throw new Ember.Error("The Application object must contain an 'env' variable which is assigned as Em.Object.create().");
    }
    var EnvReader = function EnvReader() {
      this.readEnvKeys = function() {
        // 1. Grab all the meta tags from the DOM.
        var metaTags = $("meta");
        var envVars  = {};
        // 2. Process each of the discovered meta tags.
        for( var i=0; i < metaTags.length; i++ ) {
          // 3. Get the meta tag name and value.
          var envKey   = $(metaTags[i]).attr("name");
          var envValue = $(metaTags[i]).attr("content");
          // 4. Does the meta tag start with 'env-'?
          if (/^env\-/.test(envKey)) {
            // 5. Produce a camelized version of the env variable name, ignoring the initial 'env-'.
            var propertyName = envKey.substring(4);
            // 6. Map the string values to actual types.
            envVars[propertyName] = this._mapType(envValue);
          }
        }
        return envVars;
      };
      this._mapType = function(val) {
        return "" === val ? null : "true" === val ? true : "false" === val ? false : (-1 !== val.indexOf(",") && (val = val.split(",")), val);
      };
    };
    var envReader = new EnvReader();
    application.get("env").setProperties(envReader.readEnvKeys());
  }
});
