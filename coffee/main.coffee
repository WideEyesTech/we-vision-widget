console.log products
require.config
  baseUrl: 'js'
  map:
    '*': { 'jquery': 'jquery-private' },
    'jquery-private': { 'jquery': 'jquery' }
  paths:
    'Event': 'vendor/Event/Event'
    'jquery': 'vendor/jquery/dist/jquery'
    'backbone': 'vendor/backbone/backbone'
    'underscore': 'vendor/underscore/lodash'
    'Magnifier': 'vendor/Magnifier/Magnifier'
    'handlebars.runtime': 'vendor/handlebars/handlebars.runtime'

  shim:
    'templates/widget_container':
      deps: []
    'templates/product_container':
      deps: []
    'templates/products_container':
      deps: []
  waitSeconds: 10

require [
  'jquery'
  'Loader'
], ($, Loader) -> new Loader
