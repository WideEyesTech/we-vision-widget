define (require) ->

  Backbone = require 'backbone'
  $ = require 'jquery'
  _ = require 'underscore'

  class ProductContainer extends Backbone.View
    template: require 'templates/product_container'

    events:
      'click a': '_onClick'

    initialize: (options)->
      @config = options.widget_configuration
      @product_id = options.product_id
      @

    render: ->
      if @template
        @setElement @template @_getTemplateData()
        @$el.addClass '' # Add hidden class since we'll be making transition-in to visible
        # TODO: add col classes depending on columncount
      super
      @

    _onClick: ->
      # call statistics/registerClick
      headers = {}
      headers.apikey = @config.apikey
      $.ajax
        method: "POST",
        url: "http://api.wide-eyes.it/widget/clicks",
        data: '{}'
        dataType: 'json'
        contentType: 'application/json; charset=UTF-8'
        headers: 
          headers
        crossDomain: true
        processData: false
        error: (error) =>
          console.log(error)
        success: (response) =>
        
    _getTemplateData: ->
      @model
