require.config
  baseUrl: 'js'
  map:
    # '*' means all modules will get 'jquery-private'
    # for their 'jquery' dependency.
    '*': { 'jquery': 'jquery-private' },
    # 'jquery-private' wants the real jQuery module
    # though. If this line was not here, there would
    # be an unresolvable cyclic dependency.
    'jquery-private': { 'jquery': 'jquery' }
  paths:
    'jquery': 'vendor/jquery/dist/jquery'
    'backbone': 'vendor/backbone/backbone'
    'underscore': 'vendor/underscore/lodash'
    'handlebars.runtime': 'vendor/handlebars/handlebars.runtime'

  shim:
    # Must shim all partials used in templates
    'templates/widget_container':
      deps: []
    'templates/product_container':
      deps: []
    'templates/products_container':
      deps: []
  waitSeconds: 10


# Must also manually require all partials otherwise they don't get loaded :/
#require.config
#  context: 'WideEyesWidget'
require ['jquery', 'Loader' ], ($, Loader) ->
    loader = new Loader
    $ -> loader

    window.onmessage = (e) ->
      if e.data.message == 'we-reload' and e.data.customConfig
        loader.render(e.data.customConfig)
