const { exec } = require('child_process');

/*jshint node:true*/
module.exports = {
  description: '',

  locals: function(options) {
    // Return custom template variables here.
    var input = options.args[1];
    var camelCase = input.replace(/-([a-z])/g, function (g) { return g[1].toUpperCase(); });
    var modelName = camelCase.charAt(0).toUpperCase() + camelCase.slice(1);
    return {
      modelName: modelName
    };
  },

  afterInstall: function(options) {

  }

};
