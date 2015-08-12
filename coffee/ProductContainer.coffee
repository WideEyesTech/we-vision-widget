define (require) ->

  Backbone = require 'backbone'
  _ = require 'underscore'
  $ = require 'jquery'

  class ProductContainer extends Backbone.View
    self = this
    template: require 'templates/product_container'

    initialize: (options)->
      @config = options.widget_configuration
      @product_id = options.product_id

    render: ->
      if @template
        @setElement @template @_getTemplateData()
        @$el.addClass ''
        if @config.tile.display
          @$el.mouseenter(_onMouseEnter)
          @$el.mouseleave(_onMouseLeave)
      @

    _getTemplateData: ->
      @model

_onMouseEnter = (ev) ->
  ev.currentTarget.className += " hover"

_onMouseLeave = (ev) ->
  ev.currentTarget.className = ev.currentTarget.className.replace " hover", ""