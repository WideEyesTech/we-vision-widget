require '../css/main.css'
require '../js/vendor/iframe-resizer/src/iframeResizer.contentWindow'

$ = require 'jquery'
Loader = require './Loader.coffee'

loader = new Loader
$ -> loader

window.onmessage = (e) ->
  if e.data.name == 'we-reload' and e.data
    loader.render(e.data)
