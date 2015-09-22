var webpack = require('webpack');

module.exports = {
  entry: {
    we_vision_external: ["./coffee/we_vision_external.coffee"],
    we_vision_internal: "./coffee/we_vision_internal.coffee"
  },
  output: {
    path: __dirname + "/build",
    filename: "[name].min.js"
  },
  module: {
    loaders: [{
      test: /\.coffee$/,
      exclude: /node_modules/,
      loader: "coffee-loader"
    }, {
      test: /\.(coffee\.md|litcoffee)$/,
      exclude: /node_modules/,
      loader: "coffee-loader?literate"
    }, {
      test: /\.hbs$/,
      loader: "handlebars-loader"
    }, {
      test: /\.css$/,
      loader: "style-loader!css-loader"
    }, {
      test: /\.png$/,
      loader: "url-loader?limit=100000"
    }, {
      test: /\.jpg$/,
      loader: "file-loader"
    }]
  }
};
