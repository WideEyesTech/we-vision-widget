define (require) ->

  Backbone = require 'backbone'
  $ = require 'jquery'
  _ = require 'underscore'
  ProductContainer = require 'ProductContainer'
  

  class ProductsContainer extends Backbone.View
    template: require 'templates/products_container'

    events:
      'click': '_onClick'

    initialize: (options)->
      @widget_configuration = options.widget_configuration
      @product_id = options.product_id
      @

    render: ->
      if @template
        @setElement @template @_getTemplateData()
        @$el.addClass '' # Add hidden class since we'll be making transition-in to visible
      for product, index in @model
        prc = new ProductContainer
          model: product
          product_id: @product_id
          widget_configuration: @widget_configuration
        @$el.append prc.render().el
      # call impressions
      @_finishImpression()
      super
      @
      
    _onClick: ->
      # call statistics/registerClick
      # alert('element clicked');
      true
        
    _getTemplateData: ->
      {products: @model}
      
    _finishImpression: ->

      if window.wide_eyes_config
        if window.wide_eyes_config.mode
          if window.wide_eyes_config.mode == 'debug'
            console.log('Impression finished')
            console.timeEnd("WideEyesWidget")
      # make api call
      headers = {}
      headers.apikey = @widget_configuration.apikey

      $.ajax
        method: "POST",
        url: "http://api.wide-eyes.it/widget/impressions",
        data: '{}'
        dataType: 'json'
        contentType: 'application/json; charset=UTF-8'
        headers: 
          headers
        crossDomain: true
        processData: false
        error: (error) =>
          console.log(error)
        success: (response)=>
      
